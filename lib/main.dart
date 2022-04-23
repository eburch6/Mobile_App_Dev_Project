// import 'package:final_project/upload_image.dart';
// import 'package:final_project/signup.dart';
import 'package:final_project/post_recipes.dart';
import 'package:final_project/upload_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'display_post.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: login(),
    );
  }
}
