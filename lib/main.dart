import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/ui/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', //primarySwatch is shades of colour
      theme: ThemeData(primarySwatch: Colors.lime),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
