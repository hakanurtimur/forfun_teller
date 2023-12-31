import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'package:forfun_teller/screens/logged_in_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:forfun_teller/widgets/not_enough_dialog.dart';
import 'package:intl/intl.dart';

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

  // setters

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

  void _setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  void resetImages() {
    _selectedImage1 = null;
    _selectedImage2 = null;
    _selectedImage3 = null;
    notifyListeners();
  }

  Future<void> _captureImage(ImageSource source, int imageNumber) async {
    _setIsLoading(true);
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
    }
    _setIsLoading(false);
    notifyListeners();
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
    if (_selectedImage1 != null &&
        _selectedImage2 != null &&
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
    required String uid,
  }) async {
    _setIsLoading(true);
    if (!imageCheck()) return;
    try {
      final fortuneId = const Uuid().v4();
      var url1 = await storage
          .ref('/images/$uid/fortunes/$fortuneId/fincan-aci-1')
          .putFile(_selectedImage1!);
      var url2 = await storage
          .ref('/images/$uid/fortunes/$fortuneId/fincan-aci-2')
          .putFile(_selectedImage2!);
      var url3 = await storage
          .ref('/images/$uid/fortunes/$fortuneId/fincan-tabagi')
          .putFile(_selectedImage3!);

      if (!context.mounted) return;
      await _updateUsersFortunes(
          uid: uid, fortuneId: fortuneId, context: context);
      if (!context.mounted) return;
      customToast(
          context: context,
          msg:
              'Falınız başarıyla gönderildi, 30 dakika içerisinde gelen kutunuzdan cevabınızı alabilirsiniz.',
          backgroundColor: kSuccessColor);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) {
          return const LoggedInScreen(
            initialPageIndex: 3,
          );
        }),
        (route) => false,
      );
      await fortuneCollection.doc(fortuneId).set(
        {
          'ownerAccountId': uid,
          'bornDate': bornDate,
          'ownerName': ownerName,
          'gender': gender,
          'relationship': relationship,
          'createdAt': DateTime.now(),
          'status': 'pending',
          'images': [
            url1.ref.fullPath,
            url2.ref.fullPath,
            url3.ref.fullPath,
          ],
        },
      );
      resetImages();
    } on FirebaseException catch (e) {
      if (!context.mounted) return;
      customToast(
          msg: e.message!, context: context, backgroundColor: kErrorColor);
    } finally {
      _setIsLoading(false);
    }
    notifyListeners();
  }
  // uploading images to firebase storage

  Future<void> imageUploader(BuildContext context) async {
    if (!imageCheck()) return;
    await storage.ref('/images/').putFile(_selectedImage1!);
  }

  // fortune updates

  Future<void> _updateUsersFortunes(
      {required String uid,
      required String fortuneId,
      required BuildContext context}) async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    final DocumentSnapshot snapshot = await userCollection.doc(uid).get();
    var diamondAmount = (snapshot.data() as Map)['diamondAmount'];
    if (diamondAmount < 1) {
      if (!context.mounted) return;
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => const NotEnoughDialog());
      resetImages();
      throw Exception('Yeterli elmasınız bulunmamaktadır.');
    } else {
      var fortunes = (snapshot.data() as Map)['fortunes'];
      fortunes.add(fortuneId);
      await userCollection.doc(uid).update(
        {'fortunes': fortunes, 'diamondAmount': FieldValue.increment(-1)},
      );
    }
  }

  // getting fortune amount

  Future<int> getFortuneAmount(
    String? userId,
  ) async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    final DocumentSnapshot snapshot = await userCollection.doc(userId).get();
    var fortuneAmount = (snapshot.data() as Map)['fortunes'].length;
    return fortuneAmount;
  }

  // getting success fortunes
  Stream<List<Map<String, dynamic>>?> getSuccessFortunesStream(String? userId) {
    try {
      final fortuneCollection =
          FirebaseFirestore.instance.collection('fortunes');
      final Stream<QuerySnapshot> snapshotStream = fortuneCollection
          .where('ownerAccountId', isEqualTo: userId)
          .where('status', isEqualTo: 'success')
          .snapshots();

      return snapshotStream.map((snapshot) {
        List<Map<String, dynamic>> successFortunes = [];

        for (var element in snapshot.docs) {
          successFortunes.add({
            'title': element['title'],
            'turnedAt': DateFormat.Hm().format(DateTime.timestamp()).toString(),
            'fortuneText': element['fortuneText'],
            'owner': element['ownerName'],
            'createdDate': DateFormat.Md()
                .format(element['createdAt'].toDate())
                .toString(),
            'createdAt': DateFormat.Hm()
                .format(element['createdAt'].toDate())
                .toString(),
          });
        }

        return successFortunes;
      });
    } catch (e) {
      return Stream.value(null);
    }
  }
}
