import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiamondService extends ChangeNotifier {
  Future<int> getDiamondAmount(String userId) async {
    final diamondAmountData =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return diamondAmountData.data()!['diamondAmount'];
  }
}
