// ignore_for_file: prefer_const_constructors

import 'package:events_app/api/firebaseApi.dart';
import 'package:events_app/logSign/checkUser.dart';
import 'package:events_app/logSign/login_page.dart';

import 'package:events_app/pages/HomePage.dart';
import 'package:events_app/walk_through.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: walk_through(),
        // home : login_page()
        home: checkUser()

        // home:HomePage()
        );
  }
}
