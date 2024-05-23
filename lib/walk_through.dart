// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:events_app/logSign/signIn_page.dart';
import 'package:events_app/pages/home1.dart';
import 'package:events_app/pages/home2.dart';
import 'package:events_app/pages/home3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class walk_through extends StatefulWidget {
  walk_through({super.key});

  @override
  State<walk_through> createState() => _walk_throughState();
}

class _walk_throughState extends State<walk_through> {
  //Controller keep track on which page we're on
  PageController mycontroller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(244, 244, 245, 231),
        //stack is a widget that contains a list of widgets
        // stack position the children on top of the others
        body: Stack(
          children: [
            PageView(
              controller: mycontroller,
              onPageChanged: (index) {
                setState(() {
                  onLastPage = (index == 2);
                });
              },
              children: [
                home1(),
                home2(),
                home3(),
              ],
            ),
            Container(
                alignment: Alignment(0, 1),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.9),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //skip
                      GestureDetector(
                        onTap: () {
                          mycontroller.jumpToPage(2);
                        },
                        child: Text("Skip",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins',
                            )),
                      ),

                      //dot indicator
                      SmoothPageIndicator(
                        controller: mycontroller,
                        count: 3,
                        effect: ExpandingDotsEffect(
                          dotColor: Colors.grey, // Inactive dot color
                          activeDotColor: Colors.red, // Active dot color
                        ),
                      ),

                      //next or Sign up
                      onLastPage
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => signIn_page()),
                                );
                                //     mycontroller.nextPage(
                                //     duration: Duration(milliseconds: 300),
                                //     curve: Curves.easeIn);
                              },
                              child: Text("Sign Up",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                  )),
                            )
                          : GestureDetector(
                              onTap: () {
                                mycontroller.nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              },
                              child: Text("Next",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                  )),
                            ),
                    ],
                  ),
                )),
          ],
        ));
  }
}
