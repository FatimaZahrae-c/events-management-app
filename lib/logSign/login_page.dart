// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/components/MyButton.dart';
import 'package:events_app/components/MyTextField.dart';
import 'package:events_app/logSign/signIn_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class login_page extends StatefulWidget {
  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // wrong email or password method
    void wrongInfo(String message) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade400,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    //Log in Method

    void logInUser() async {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          });

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        
        firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': emailController.text,
        }, SetOptions(merge: true));
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        wrongInfo(e.code);
      }
    }

    // redirection to sign in

    void createAccount() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => signIn_page()),
      );
    }

    return Scaffold(
        backgroundColor: Color.fromARGB(244, 244, 245, 231),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 35),

              // logo

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.star_rate_outlined,
                    size: 50,
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(height: 30),
              // title

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    "Welcome back ,",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),
              //text

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    "We're delighted to have you here again.               Please provide your email address and password",
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 15,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),

              //email

              MyTextField(
                controller: emailController,
                text: 'Email',
                passwordHidden: false,
              ),

              SizedBox(height: 10),

              //password

              MyTextField(
                controller: passwordController,
                text: 'Password',
                passwordHidden: true,
              ),

              SizedBox(height: 30),

              // login button
              MyButton(
                buttontext: 'Log in',
                onTap: logInUser,
                color: Colors.red,
                textColor: Colors.white,
              ),
              SizedBox(height: 10),

              // forgot password

              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              SizedBox(height: 10),

              //or line

              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          'or',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // create account button

              MyButton(
                  onTap: createAccount,
                  buttontext: 'Create an account',
                  color: Colors.black,
                  textColor: Colors.white),
            ],
          ),
        )));
  }
}
