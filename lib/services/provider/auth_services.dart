import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forfun_teller/constants.dart';

class AuthServices extends ChangeNotifier {
  final userColection = FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> signUpWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    _setLoading(true);
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await _registration(
          email: email, password: password, uid: userCredential.user!.uid);

      customToast(
          context: context,
          msg: 'Kayıt başarılı',
          backgroundColor: kSuccessColor);
      Navigator.pushNamed(context, '/logged');
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
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);
      customToast(
          context: context,
          msg: 'Giriş başarılı',
          backgroundColor: kSuccessColor);
      Navigator.pushNamed(context, '/logged');
    } on FirebaseAuthException catch (e) {
      customToast(
          msg: e.message!, context: context, backgroundColor: kErrorColor);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _registration(
      {required String email,
      required String password,
      required String uid}) async {
    await userColection.doc(uid).set(
      {
        'email': email,
        'password': password,
      },
    );
  }
}
