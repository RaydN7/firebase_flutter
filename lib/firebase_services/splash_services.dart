import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/ui/auth/login_screen.dart';
//import 'package:firebase_project/ui/firestore/firestore_list_screen.dart';
import 'package:firebase_project/ui/upload_image.dart';
// import 'package:firebase_project/ui/posts/post_screen.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser; //to know user is already loggined or not
    if (user != null) {
      Timer(
          //first splash screen displayed and then login screen
          const Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (cotext) => UploadImageScreen())));
    } else {
      Timer(
          //first splash screen displayed and then login screen
          const Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (cotext) => LoginScreen())));
    }
  }
}

// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_project/ui/auth/login_screen.dart';
// import 'package:firebase_project/ui/firestore/firestore_list_screen.dart';
// // import 'package:firebase_project/ui/posts/post_screen.dart';
// import 'package:flutter/material.dart';

// class SplashServices {
//   void isLogin(BuildContext context) {
//     final auth = FirebaseAuth.instance;
//     final user = auth.currentUser; //to know user is already loggined or not
//     if (user != null) {
//       Timer(
//           //first splash screen displayed and then login screen
//           const Duration(seconds: 3),
//           () => Navigator.push(context,
//               MaterialPageRoute(builder: (cotext) => FireStoreScreen())));
//     } else {
//       Timer(
//           //first splash screen displayed and then login screen
//           const Duration(seconds: 3),
//           () => Navigator.push(
//               context, MaterialPageRoute(builder: (cotext) => LoginScreen())));
//     }
//   }
// }

// class SplashServices {
//   void isLogin(BuildContext context) {
//     final auth = FirebaseAuth.instance;
//     final user = auth.currentUser; //to know user is already loggined or not
//     if (user != null) {
//       Timer(
//           //first splash screen displayed and then login screen
//           const Duration(seconds: 3),
//           () => Navigator.push(
//               context, MaterialPageRoute(builder: (cotext) => PostScreen())));
//     } else {
//       Timer(
//           //first splash screen displayed and then login screen
//           const Duration(seconds: 3),
//           () => Navigator.push(
//               context, MaterialPageRoute(builder: (cotext) => LoginScreen())));
//     }
//   }
// }
