import 'package:daebok/Home.dart';
import 'package:daebok/estimate.dart';
import 'package:daebok/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  statusBarColor: Colors.transparent, // 투명색
  ));

    return GetMaterialApp(
      title: '대영복사',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Hanna11",
      ),
      home: HomePage(),

    );
  }
}
