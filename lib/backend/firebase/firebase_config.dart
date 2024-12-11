import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAdvcLuMnDA6oqHO_91QKBXtW8Ky1MyNOE",
            authDomain: "geap-xxrjcl.firebaseapp.com",
            projectId: "geap-xxrjcl",
            storageBucket: "geap-xxrjcl.appspot.com",
            messagingSenderId: "1069627979810",
            appId: "1:1069627979810:web:2c5ecbbca7760491f5f27b"));
  } else {
    await Firebase.initializeApp();
  }
}
