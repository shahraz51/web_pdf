import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:web_pdf/MyHomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyB15gbXQhUIc93xl2e_toFNMoKMv_v0L7Y",
          appId: "1:621357409691:web:dc5552c05b0b598d23ed3e",
          messagingSenderId: "621357409691",
          projectId: "uploadandreadpdf",
          storageBucket: "uploadandreadpdf.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
