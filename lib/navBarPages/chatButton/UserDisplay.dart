import 'package:flutter/material.dart';

class UserDisplay extends StatelessWidget {
  final void Function()? ontap;
  final String text;

  const UserDisplay({super.key, required this.ontap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18, top: 10),
      child: GestureDetector(
          onTap: ontap,
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.red,
                ),
                SizedBox(width: 10),
                Text(text, style: TextStyle(fontFamily: 'Poppins'))
              ],
            ),
          )),
    );
  }
}
