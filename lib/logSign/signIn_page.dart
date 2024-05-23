// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/components/MyButton.dart';
import 'package:events_app/components/MyTextField.dart';
import 'package:events_app/logSign/authService.dart';
import 'package:events_app/logSign/login_page.dart';

import 'package:events_app/walk_through.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class signIn_page extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
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

    //sign up Method

    void SignUpUser() async {
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
        if (passwordController.text == confirmPasswordController.text) {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text);

          firestore.collection('users').doc(userCredential.user!.uid).set({
            'uid': userCredential.user!.uid,
            'email': emailController.text,
          });

          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          wrongInfo('Passwords does\'nt match !');
        }
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        wrongInfo(e.code);
      }
    }

    // google sign up

    void googleSignUp() {}

    //facebook sign up

    void facebookSignUp() {}

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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => walk_through()));
                    },
                    child: Icon(
                      Icons.arrow_circle_left_rounded,
                      size: 40,
                      color: Colors.red,
                    ),
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
                    "Create an account",
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
                    "Create your account. Please provide your email address and password",
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

              SizedBox(height: 10),

              //Confirm password

              MyTextField(
                controller: confirmPasswordController,
                text: 'Confirm Password',
                passwordHidden: true,
              ),

              SizedBox(height: 30),

              // SignIn button
              MyButton(
                buttontext: 'Sign Up',
                onTap: SignUpUser,
                color: Colors.red,
                textColor: Colors.white,
              ),
              SizedBox(height: 10),

              SizedBox(height: 10),

              //or line

              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          child: Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
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
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          child: Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),

              // google + facebook sign up

              GestureDetector(
                onTap: () => authService().signInWithGoogle(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('lib/assets/google.png', height: 40),
                  ],
                ),
              ),
              SizedBox(height: 25),

              // already have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account ?",
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => login_page()));
                    },
                    child: Text(
                      "Log in",
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )));
  }
}
