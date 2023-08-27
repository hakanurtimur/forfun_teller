import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'dart:io';

import 'package:forfun_teller/constants.dart';

class StorageService extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final storage = FirebaseStorage.instance;

  Future<String> imageUploader(File image, String imageName) async {
    _setLoading(true);
    try {
      await storage.ref('/images/$imageName').putFile(image);
    } on firebase_core.FirebaseException catch (e) {
      print(e.code);
    } finally {
      _setLoading(false);
    }
    notifyListeners();
    return '';
  }
}
