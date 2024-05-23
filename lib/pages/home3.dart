// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class home3 extends StatefulWidget {
  home3({super.key});

  @override
  State<home3> createState() => _home3State();
}

class _home3State extends State<home3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(child: Container(
        color: Color.fromARGB(244, 244, 245, 231),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset('lib/assets/femaleAvatar1.png'),
                      Positioned(
                        bottom: 0,
                        top : 150,
                        left : 70,
                        child: Row(
                          children: [
                            Center(child: Icon(Icons.check_circle_rounded, size: 40, color: Colors.green)),
                            SizedBox(width: 10),
                           
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset('lib/assets/maleAvatar.png'),
                       Positioned(
                        bottom: 0,
                        top : 150,
                        left : 70,
                        child: Row(
                          children: [
                            Center(child: Icon(Icons.delete_forever_rounded, size: 40, color: Colors.red)),
                            SizedBox(width: 10),
                           
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.only(top :33.0),
              child: Text(
                "Accept or Deny Request",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                "Swipe, tap, or follow the intuitive steps to effortlessly manage incoming requests. Let's make your event planning journey smooth!",
                style: TextStyle(
                   fontFamily: 'Rubik',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                 
                ),
              ),
            ),
          ],
        ),
      ),) 
    );
  }
}
