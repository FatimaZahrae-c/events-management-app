import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  final controller;  //access to what the users type
  final String text;  //hintText
  final passwordHidden ;  //hiddenpassword

  const MyTextField({super.key,
  required this.controller,
  required this.text,
  required this.passwordHidden
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller : controller,
        obscureText: passwordHidden,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade900,
            ),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: text,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
          )
        ),
      ),
    );
  }
}
