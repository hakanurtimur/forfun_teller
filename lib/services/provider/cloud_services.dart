import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudServices extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final tarotColection = FirebaseFirestore.instance.collection('tarots');

  Future<dynamic> getTarotById(String id) async {
    _setLoading(true);
    try {
      final tarot = await tarotColection.doc(id).get();
      return {
        'title': tarot.data()!['title'],
        'desc': tarot.data()!['desc'],
        'imageUrl': tarot.data()!['imageUrl'],
      };
    } on FirebaseException catch (e) {
      // TODO
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }
}
