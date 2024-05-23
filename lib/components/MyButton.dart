// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttontext;
  final Color color;
  final Color textColor;

  final Function()? onTap; // ? indicates it can be null

  const MyButton(
      {super.key,
      required this.onTap,
      required this.buttontext,
      required this.color,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(17),
          margin: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              buttontext,
              style: TextStyle(
                color: textColor,
                fontFamily: 'Poppins',
                fontSize: 17,
              ),
            ),
          ),
        ));
  }
}
