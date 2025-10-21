import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_with_firebase/core/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCHKnz4svlMJ0DiBECDrsgWyLYltUUh3X8",
        authDomain: "basic-login-527b6.firebaseapp.com",
        projectId: "basic-login-527b6",
        storageBucket: "basic-login-527b6.firebasestorage.app",
        messagingSenderId: "679009176627",
        appId: "1:679009176627:web:e9a1a649e6f04122e52746",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(),
      home: const Wrapper(),
    );
  }
}
