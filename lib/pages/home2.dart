// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class home2 extends StatelessWidget {
  home2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(child: Container(
        color: Color.fromARGB(244, 244, 245, 231),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: 80,
                width: 320,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 200.0, bottom: 0),
                      child: Image.asset('lib/assets/femaleAvatar1.png'),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 43, right: 40),
                            child: Container(
                              height: 17,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 9, right: 130),
                            child: Container(
                              height: 14,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40, bottom: 20),
                            child: Container(
                              height: 10,
                              width: 190,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0, top: 10),
              child: Container(
                height: 80,
                width: 320,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 200.0, bottom: 0),
                      child: Image.asset('lib/assets/maleAvatar.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 280.0, top: 21),
                      child: Icon(Icons.share,
                      color: Colors.blue[800],
                      size : 42,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 43, right: 40),
                            child: Container(
                              height: 17,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 9, right: 130),
                            child: Container(
                              height: 14,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40, bottom: 20),
                            child: Stack(
                              children: [
                                Container(
                                  height: 10,
                                  width: 190,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                               
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50, top: 10),
              child: Container(
                height: 80,
                width: 320,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 200.0, bottom: 0),
                      child: Image.asset('lib/assets/female2.png'),
                    ),
                    
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 43, right: 40),
                            child: Container(
                              height: 17,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 9, right: 130),
                            child: Container(
                              height: 14,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40, bottom: 20),
                            child: Container(
                              height: 10,
                              width: 190,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                "Invite",
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
                "Inviting participants is as simple as a few taps. Connect with your community by sending out invitations.",
                style: TextStyle(
                  color: Colors.black,
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
