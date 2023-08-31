import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forfun_teller/constants.dart';

class TarotServices extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final tarotCollection = FirebaseFirestore.instance.collection('tarots');
  final tarotMeaningsCollection =
      FirebaseFirestore.instance.collection('tarotMeanings');

  Future<dynamic> getTarotById(String tarot1id, String tarot2id,
      String tarot3id, BuildContext context) async {
    _setLoading(true);
    try {
      // bir servisten isimlerle veya idlerle kartların anlamlarını çeker,
      // ayrıca kombine anlamı çeker, bunları bir map olarak döner
      var tarot1 = await tarotCollection.doc(tarot1id).get();
      var tarot2 = await tarotCollection.doc(tarot2id).get();
      var tarot3 = await tarotCollection.doc(tarot3id).get();
      var combineMeaning = await tarotMeaningsCollection.doc('combine1').get();

      var tarot1info = {
        'title': tarot1.data()!['title'],
        'desc': tarot1.data()!['desc'],
      };
      var tarot2info = {
        'title': tarot2.data()!['title'],
        'desc': tarot2.data()!['desc'],
      };
      var tarot3info = {
        'title': tarot3.data()!['title'],
        'desc': tarot3.data()!['desc'],
      };
      var combineMeaningInfo = {
        'desc': combineMeaning.data()!['desc'],
      };
      return {
        'tarot1': tarot1info,
        'tarot2': tarot2info,
        'tarot3': tarot3info,
        'combineMeaning': combineMeaningInfo,
      };
    } on FirebaseException catch (e) {
      if (!context.mounted) return;
      customToast(
          msg: e.message!, backgroundColor: kErrorColor, context: context);
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }
}
