import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

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
    required String uid,
  }) async {
    _isLoading = true;
    if (!imageCheck()) return;
    try {
      // await storage.ref('/images/').putFile(_selectedImage1!);
      final fortuneId = Uuid().v4();
      await _updateUsersFortunes(
          uid: uid, fortuneId: fortuneId, context: context);
      customToast(
          context: context,
          msg:
              'Falınız başarıyla gönderildi, 30 dakika içerisinde gelen kutunuzdan cevabınızı alabilirsiniz.',
          backgroundColor: kSuccessColor);
      Navigator.pushNamed(context, '/logged');
      ;
      await fortuneCollection.doc(fortuneId).set(
        {
          'ownerAccountId': currentUser!.uid,
          'bornDate': bornDate,
          'ownerName': ownerName,
          'gender': gender,
          'relationship': relationship,
          'createdAt': DateTime.now(),
          'status': 'pending',
        },
      );
      resetImages();
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

  Future<void> _updateUsersFortunes(
      {required String uid,
      required String fortuneId,
      required BuildContext context}) async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    final DocumentSnapshot snapshot = await userCollection.doc(uid).get();
    var diamondAmount = (snapshot.data() as Map)['diamondAmount'];
    if (diamondAmount < 1) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => NotEnaughDialog());
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
}

class NotEnaughDialog extends StatelessWidget {
  NotEnaughDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Yeterli Forfun Diamond'ınız yok.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
              PadderBox(),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/logged');
                },
                child: Text('Mağazaya git',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    )),
                style: kOutlinedButtonStyle,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/logged');
                },
                child: Text('Ana Sayfaya Dön',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    )),
                style: kOutlinedButtonStyle,
              ),
            ],
          )),
    );
  }
}
