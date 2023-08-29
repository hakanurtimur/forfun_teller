import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forfun_teller/constants.dart';

class DiamondService extends ChangeNotifier {
  bool _sellingDiamondLoading = false;

  bool get sellingDiamondLoading => _sellingDiamondLoading;
  void setSellingDiamondLoading(bool value) {
    _sellingDiamondLoading = value;
    notifyListeners();
  }

  Future<int> getDiamondAmount(String userId) async {
    final diamondAmountData =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return diamondAmountData.data()!['diamondAmount'];
  }

  Future<void> sellingDiamondAmount(
      String userId, int boughtDiamondAmount, BuildContext context) async {
    // PAYMENT SERVICES
    try {
      setSellingDiamondLoading(true);
      final userCollection = FirebaseFirestore.instance.collection('users');
      final userDoc = await userCollection.doc(userId).get();
      var diamondAmount = userDoc.data()!['diamondAmount'];
      diamondAmount += boughtDiamondAmount;
      await userCollection.doc(userId).update({'diamondAmount': diamondAmount});
      customToast(
          msg: 'Satın alma başarılı',
          context: context,
          backgroundColor: kSuccessColor);
    } on FirebaseException catch (e) {
      customToast(
          msg: e.message!, context: context, backgroundColor: kErrorColor);
    } finally {
      _sellingDiamondLoading = false;
    }
    notifyListeners();
  }
}
