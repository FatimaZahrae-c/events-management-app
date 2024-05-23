// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class chatBubble extends StatelessWidget {
  final String message;
  const chatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9), color: Colors.red),
      child: Text(message, style: TextStyle(fontSize: 17, color: Colors.white)),
    );
  }
}
