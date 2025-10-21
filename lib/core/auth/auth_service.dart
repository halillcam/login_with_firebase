import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  Future<User?> createUserWithEmailandPassword(
    String email,
    String password,
  ) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred.user;
    } on FirebaseAuthException catch (e) {
      exceptionHandler(e.code);
    } catch (e) {
      log("Hata $e");
    }
    return null;
  }

  Future<User?> loginUserWithEmailandPassword(
    String email,
    String password,
  ) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred.user;
    } on FirebaseAuthException catch (e) {
      exceptionHandler(e.code);
    } catch (e) {
      log("Hata $e");
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("hata $e");
    }
  }
}

exceptionHandler(String code) {
  switch (code) {
    case "invaild-credential":
      log("giris bilgileriniz gecersiz");
    case "weak-password":
      log("zayif sifre");
    case "email-already-in-use":
      log("kullanici zaten kayitli");
    default:
      log("hata");
  }
}
