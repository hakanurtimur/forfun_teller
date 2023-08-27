import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FortuneServices extends ChangeNotifier {
  // private variables
  File? _selectedImage1;
  File? _selectedImage2;
  File? _selectedImage3;
  bool _isLoading = false;

  final currentUser = FirebaseAuth.instance.currentUser;
  final fortuneCollection = FirebaseFirestore.instance.collection('fortunes');
  final storage = FirebaseStorage.instance;

  // getters for private variables
  File? get selectedImage1 => _selectedImage1;
  File? get selectedImage2 => _selectedImage2;
  File? get selectedImage3 => _selectedImage3;
  bool get isLoading => _isLoading;

  File? getSelectedImageByNumber(index) {
    if (index == 0) {
      return _selectedImage1;
    } else if (index == 1) {
      return _selectedImage2;
    } else if (index == 2) {
      return _selectedImage3;
    } else {
      return null;
    }
  }

  void resetImages() {
    _selectedImage1 = null;
    _selectedImage2 = null;
    _selectedImage3 = null;
    notifyListeners();
  }

  Future<void> _captureImage(ImageSource source, int imageNumber) async {
    _isLoading = true;
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: source);
    if (image != null) {
      if (imageNumber == 1) {
        _selectedImage1 = File(image.path);
      } else if (imageNumber == 2) {
        _selectedImage2 = File(image.path);
      } else if (imageNumber == 3) {
        _selectedImage3 = File(image.path);
      }
      _isLoading = false;
      notifyListeners();
    }
  }

  // capturing image from gallery or camera

  Future<void> captureImageFromGallery(int imageNumber) async {
    await _captureImage(ImageSource.gallery, imageNumber);
  }

  Future<void> captureImageFromCamera(int imageNumber) async {
    await _captureImage(ImageSource.camera, imageNumber);
  }

  // checking if there is any image selected
  bool imageCheck() {
    if (_selectedImage1 != null ||
        _selectedImage2 != null ||
        _selectedImage3 != null) {
      return true;
    } else {
      return false;
    }
  }

  // uploading fortune images to cloud and getting the url
  Future<void> setFortune({
    required DateTime bornDate,
    required String ownerName,
    required String relationship,
    required String gender,
    required BuildContext context,
  }) async {
    _isLoading = true;
    if (!imageCheck()) return;
    try {
      await storage.ref('/images/').putFile(_selectedImage1!);
      await fortuneCollection.doc().set(
        {
          'ownerAccountId': currentUser!.uid,
          'bornDate': bornDate,
          'ownerName': ownerName,
          'gender': gender,
          'relationship': relationship,
          'createdAt': DateTime.now(),
        },
      );
      customToast(
          context: context,
          msg:
              'Falınız başarıyla gönderildi, 30 dakika içerisinde gelen kutunuzdan cevabınızı alabilirsiniz.',
          backgroundColor: kSuccessColor);
      Navigator.pushNamed(context, '/logged');
    } on FirebaseException catch (e) {
      customToast(
          msg: e.message!, context: context, backgroundColor: kErrorColor);
    } finally {
      _isLoading = false;
    }
    notifyListeners();
  }
  // uploading images to firebase storage

  Future<void> imageUploader(BuildContext context) async {
    if (!imageCheck()) return;
    await storage.ref('/images/').putFile(_selectedImage1!);
  }
}

// rules_version = '2';
//
// // Craft rules based on data in your Firestore database
// // allow write: if firestore.get(
// //    /databases/(default)/documents/users/$(request.auth.uid)).data.isAdmin;
// service firebase.storage {
// match /b/{bucket}/o {
// match /{allPaths=**} {
// allow read, write: if true;
// }
// }
// }
