import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forfun_teller/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class AuthServices extends ChangeNotifier {
  final userCollection = FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance;

  bool _imagePickerLoading = false;
  bool _isLoading = false;
  File? _selectedImage;
  final storage = FirebaseStorage.instance;
  bool get isLoading => _isLoading;
  bool get imagePickerLoading => _imagePickerLoading;
  File? get selectedImage => _selectedImage;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // auth functions
  Future<void> forgetPassword(email) async {
    return await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signUpWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    _setLoading(true);
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await _registrationForFirestore(
          email: email, password: password, uid: userCredential.user!.uid);
      if (!context.mounted) return;
      customToast(
          context: context,
          msg: 'Kayıt başarılı',
          backgroundColor: kSuccessColor);
      Navigator.pushNamedAndRemoveUntil(
          context, '/update_profile', (route) => false);
    } on FirebaseAuthException catch (e) {
      customToast(
          msg: e.message!, context: context, backgroundColor: kErrorColor);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loginWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    _setLoading(true);
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      if (!context.mounted) return;
      customToast(
          context: context,
          msg: 'Giriş başarılı',
          backgroundColor: kSuccessColor);
      Navigator.pushNamedAndRemoveUntil(context, '/logged', (route) => false);
    } on FirebaseAuthException catch (e) {
      customToast(
          msg: e.message!, context: context, backgroundColor: kErrorColor);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateProfile(
      {required String name,
      required String email,
      required context,
      required User currentUser}) async {
    _setLoading(true);
    try {
      String? photoURL = currentUser.photoURL;
      if (_selectedImage != null) {
        photoURL = await _imageUploader(currentUser);
      }
      await currentUser.updateDisplayName(name);
      await currentUser.updateEmail(email);
      await currentUser.updatePhotoURL(photoURL);
      await _updateUserForFirestore(
          email: email,
          uid: currentUser.uid,
          userName: name,
          photoURL: photoURL);
      customToast(
          msg: 'Profil güncellendi',
          backgroundColor: kSuccessColor,
          context: context);
    } on FirebaseAuthException catch (e) {
      customToast(
          msg: e.message!, backgroundColor: kErrorColor, context: context);
    } finally {
      resetImage();
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  // firestore functions

  Future<void> _registrationForFirestore(
      {required String email,
      required String password,
      required String uid}) async {
    await userCollection.doc(uid).set(
      {
        'email': email,
        'password': password,
        'userName': '',
        'photoURL': '',
        'fortunes': [],
        'diamondAmount': 0,
        'tarotCardAmount': 0,
        'submittedUser': [],
      },
    );
  }

  Future<void> _updateUserForFirestore({
    required String email,
    required String uid,
    required String userName,
    required String? photoURL,
  }) async {
    await userCollection.doc(uid).update({
      'email': email,
      'userName': userName,
      'photoURL': photoURL,
    });
  }

  // image picker functions

  Future<void> _captureNewProfileImage(source, context) async {
    _imagePickerLoading = true;
    try {
      final ImagePicker picker = ImagePicker();
      final image = await picker.pickImage(source: source);
      if (image != null) {
        _selectedImage = File(image.path);
      }
    } catch (e) {
      customToast(
          msg: 'Fotoğraf yüklenirken bir hata oluştu.',
          context: context,
          backgroundColor: kErrorColor);
    }
    _imagePickerLoading = false;
    notifyListeners();
  }

  Future<void> captureImageFromGallery(context) async {
    await _captureNewProfileImage(ImageSource.gallery, context);
  }

  Future<void> captureImageFromCamera(context) async {
    await _captureNewProfileImage(ImageSource.camera, context);
  }

  Future<String?> _imageUploader(user) async {
    final file =
        await storage.ref('/images/${user.uid}').putFile(_selectedImage!);
    final url = await file.ref.getDownloadURL();
    return url;
  }

  void resetImage() {
    _selectedImage = null;
    notifyListeners();
  }
}
