// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class home1 extends StatefulWidget {
  home1({super.key});

  @override
  State<home1> createState() => _home1State();
}

class _home1State extends State<home1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(
        color: Color.fromARGB(244, 244, 245, 231),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Center(child: Image.asset('lib/assets/calendrier.png')),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Text(
                "Create your Event",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.red,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 50, left: 30, right: 30, bottom: 100),
              child: Text(
                "Welcome to EVENTS , where your events come to life! create your own event. Set a date , check you guest list & find out more features",
                style: TextStyle(
                   fontFamily: 'Rubik',
                   fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),) 
    );
  }
}
