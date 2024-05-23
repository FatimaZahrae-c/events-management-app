// ignore_for_file: prefer_const_constructors

import 'package:events_app/components/MyButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class editProfile extends StatefulWidget {
  const editProfile({super.key});

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final birthController = TextEditingController();
  final genderController = TextEditingController();

  String selectedGender = '';
  @override
  void initState() {
    super.initState();
    // Load user inputs when the widget initializes
    loadUserInputs();
  }

  void loadUserInputs() async {
    // Retrieve current user
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // Retrieve user data from Firestore
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      // Update text fields with user data
      setState(() {
        firstNameController.text = userData['firstName'] ?? '';
        lastNameController.text = userData['lastName'] ?? '';
        emailController.text = userData['email'] ?? '';
        birthController.text = userData['birthDate'] ?? '';
        selectedGender = userData['gender'] ?? '';
      });
    }
  }

  void save() async {
    // Retrieve current user
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // Save user inputs to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .set({
        'uid': currentUser.uid,
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'email': emailController.text,
        'birthDate': birthController.text,
        'gender': selectedGender,
      });

      // Show a message that the profile has been saved
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.greenAccent[700],
        content: Text('Profile saved successfully'),
      ));
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(244, 244, 245, 231),

        // app Bar

        appBar: AppBar(
          backgroundColor: Color.fromARGB(244, 244, 245, 231),
          toolbarHeight: 60,
          actions: [
            Text('Profile',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                )),
            SizedBox(width: 110),
            IconButton(
              onPressed: logout,
              icon: Icon(Icons.logout_outlined),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(children: [
              // profile image
              Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Icon(
                    Icons.person,
                    size: 70,
                  )),

              SizedBox(height: 10),

              // first name input

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text('First Name : ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      )),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: firstNameController,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_2,
                    ),
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
                    hintText: 'First name',
                    contentPadding: EdgeInsets.symmetric(vertical: 13.0),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // last name

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text('Last Name : ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      )),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: lastNameController,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_2,
                    ),
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
                    hintText: 'Last name',
                    contentPadding: EdgeInsets.symmetric(vertical: 13.0),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // email
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text('Email : ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      )),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: emailController,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.mail,
                    ),
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
                    hintText: 'Email',
                    contentPadding: EdgeInsets.symmetric(vertical: 13.0),
                  ),
                ),
              ),

              SizedBox(height: 10),

              // date of birth
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text('Date of birth : ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      )),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: birthController,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.cake,
                    ),
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
                    hintText: 'Date of birth',
                    contentPadding: EdgeInsets.symmetric(vertical: 13.0),
                  ),
                ),
              ),

              SizedBox(height: 10),

              //radio buttons

              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(children: [
                    Radio(
                      value: 'Male',
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value as String;
                          genderController.text = selectedGender;
                        });
                      },
                      activeColor: Colors.red,
                      focusColor: Colors.black,
                    ),
                    Text(
                      'Male',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    Radio(
                      value: 'Female',
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value as String;
                          genderController.text = selectedGender;
                        });
                      },
                      activeColor: Colors.red,
                      focusColor: Colors.black,
                    ),
                    Text(
                      'Female',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
              ),

              SizedBox(height: 20),

              // save

              MyButton(
                  onTap: save,
                  buttontext: 'Save',
                  color: Colors.red,
                  textColor: Colors.black)
            ]),
          ),
        ));
  }
}
