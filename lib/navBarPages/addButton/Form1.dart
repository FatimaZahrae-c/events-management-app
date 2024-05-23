// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/components/MyButton.dart';
import 'package:events_app/components/MyTextField.dart';
import 'package:events_app/navBarPages/addButton/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Person {
  final String id;
  final String name;
  final String email;
  bool sent;

  Person(this.id, this.name, this.email, {bool? sent})
      : sent = sent ??
            false; // false if no value is specified to the sent property
}

class Form1 extends StatefulWidget {
  Form1({super.key});

  @override
  State<Form1> createState() => _Form1State();
}

class _Form1State extends State<Form1> {
  double _currentPageIndex = 0;

  final titleController = TextEditingController();

  final descriptioncontroller = TextEditingController();

  final detailedDescriptioncontroller = TextEditingController();

  DateTime? selectedDate;

  final dateController = TextEditingController();

  final timeController = TextEditingController();

  final locationController = TextEditingController();

  // List<Person> invitedPeople = [
  //   Person('Abdelkrim Laaroussi', 'abdelkrimlaaroussi@gmail.com'),
  //   Person('Bahija El Ouad', 'bahijaouad@gmail.com'),
  //   Person('Meryem Fahmi', 'meryemfahmi@gmail.com'),
  //   Person('Nada Belachqer', 'nadabelachqer@gmail.com'),
  // ];


  List<Person> selectedPeople = [];
  
  void toggleSentState(Person person) {
    setState(() {
      person.sent = !person.sent;
    });
  }

  void updateUserList(Person person) {
    setState(() {
      toggleSentState(person);
      if (selectedPeople.contains(person)) {
        selectedPeople.removeWhere((p) => p.id == person.id && p.sent);
      } else {
        selectedPeople.add(person);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget buildUserListItem(DocumentSnapshot document, BuildContext context,
        void Function(Person) updateUserList, List<Person> selectedPeople) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

      // Get the ID of the current user if available
      String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

      // Check if the current user ID is available and if it matches the document's ID
      if (currentUserId != null && document.id == currentUserId) {
        // Skip rendering the current user
        return SizedBox.shrink();
      }

      String id = document.id;
      String name = data['name'] ?? '';
      String email = data['email'] ?? '';

      return Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 10),
        child: Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              email,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            leading: InkWell(
              onTap: () {
                updateUserList(
                    Person(id, name, email)); 
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  selectedPeople.any((person) => person.id == id && person.sent)
                      ? Icons
                          .check_box // Si l'utilisateur est invité, afficher l'icône "checked"
                      : Icons.send, // Sinon, afficher l'icône "send"
                  color: selectedPeople
                          .any((person) => person.id == id && person.sent)
                      ? Colors
                          .green // Si l'utilisateur est invité, afficher en vert
                      : Colors.red, // Sinon, afficher en rouge
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget buildUserList() {
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>(
                  (doc) => buildUserListItem(
                      doc, context, updateUserList, selectedPeople),
                )
                .toList(),
          );
        },
      );
    }

    void _updatePageIndex() {
      double filledFieldsCount = 0;
      if (titleController.text.isNotEmpty &&
          descriptioncontroller.text.isNotEmpty &&
          detailedDescriptioncontroller.text.isNotEmpty)
        filledFieldsCount = filledFieldsCount + 1 / 3;

      if (dateController.text.isNotEmpty &&
          timeController.text.isNotEmpty &&
          locationController.text.isNotEmpty)
        filledFieldsCount = filledFieldsCount + 1 / 3;

      setState(() {
        _currentPageIndex = filledFieldsCount;
      });
    }

    Future<Null> _selectDate(BuildContext context) async {
      _updatePageIndex();
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101),
      );
      if (picked != null) {
        dateController.text = '${picked.day}-${picked.month}-${picked.year}';
      }
    }

    void _showTimePicker() {
      showTimePicker(context: context, initialTime: TimeOfDay.now())
          .then((TimeOfDay? value) {
        if (value != null) {
          setState(() {
            timeController.text = value.format(context);
          });
        }
      });
    }

    void logout() {
      FirebaseAuth.instance.signOut();
    }

    void next() {
      List<String> invitedPeopleNames =
          selectedPeople.map((person) => person.email).toList();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => result(
            title: titleController.text,
            description: descriptioncontroller.text,
            detailedDescription: detailedDescriptioncontroller.text,
            date: dateController.text,
            time: timeController.text,
            location: locationController.text,
            invitedPeopleNames: invitedPeopleNames,
            onSend: () {
              //  vide
            },
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Color.fromARGB(244, 244, 245, 231),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(244, 244, 245, 231),
          toolbarHeight: 60,
          actions: [
            Text(
              'New Event',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
              ),
            ),
            SizedBox(width: 95),
            IconButton(
              onPressed: logout,
              icon: Icon(Icons.logout_outlined),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              LinearPercentIndicator(
                lineHeight: 5,
                progressColor: Colors.red,
                percent: _currentPageIndex,
                backgroundColor: Colors.red.shade100,
              ),
              SizedBox(height: 10),

              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.star_rate_outlined,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Text('Step 1',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 17,
                      )),
                ],
              ),

              SizedBox(height: 30),

              // title textfield

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text('Enter the Event\'s title : ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      )),
                ),
              ),
              SizedBox(height: 10),
              MyTextField(
                  controller: titleController,
                  text: 'Title',
                  passwordHidden: false),

              SizedBox(height: 20),
              // description textfield

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text('Enter the Event\'s Description : ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      )),
                ),
              ),
              SizedBox(height: 10),
              MyTextField(
                  controller: descriptioncontroller,
                  text: 'Description',
                  passwordHidden: false),

              SizedBox(height: 20),
              // detailed description textfield

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text('Enter a detailed description of the Event\'s : ',
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
                    maxLines: 3,
                    controller: detailedDescriptioncontroller,
                    obscureText: false,
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
                        hintText: '...',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                        )),
                  )),
              SizedBox(height: 30),
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.star_rate_outlined,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Text('Step 2',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 17,
                      )),
                ],
              ),

              SizedBox(height: 30),

              // date textfield

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text('Select the date : ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      )),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Text(
                        'Date',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                    TextField(
                      controller: dateController,
                      obscureText: false,
                      readOnly: true,
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
                        hintText: 'Date',
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // time textfield

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text('Select the time : ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      )),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Text(
                        'Time',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                    TextField(
                      controller: timeController,
                      obscureText: false,
                      readOnly: true,
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
                        hintText: 'Time',
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.alarm),
                      onPressed: () {
                        _showTimePicker();
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // location textfield

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text('Enter the location : ',
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
                    controller: locationController,
                    obscureText: false,
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
                        hintText: 'Location',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                        )),
                  )),

              SizedBox(height: 30),
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.star_rate_outlined,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Text('Step 3',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 17,
                      )),
                ],
              ),

              SizedBox(height: 30),

              Padding(
                padding:
                    const EdgeInsets.only(bottom: 8.0, top: 8.0, right: 210),
                child: Text(
                  'Send Invites',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              SizedBox(height: 10),

              //  Cards for each person

              SizedBox(
                height: 200, // Set the height as per your requirement
                child: buildUserList(),
              ),

              // Column(
              //   children: invitedPeople.map((person) {
              //     return Padding(
              //         padding: const EdgeInsets.only(
              //             right: 8.0, left: 8.0, bottom: 10),
              //         child: Card(
              //           elevation: 4,
              //           child: ListTile(
              //             title: Text(
              //               person.name,
              //               style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //             subtitle: Text(person.email),
              //             leading: InkWell(
              //               onTap: () {
              //                 setState(() {
              //                   _updatePageIndex();
              //                   person.sent = !person.sent;
              //                 });
              //               },
              //               child: Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: person.sent
              //                     ? Icon(Icons.check_box,
              //                         color: Colors.green, // is true
              //                         size: 24)
              //                     : Icon(
              //                         Icons.send,
              //                         color: Colors.red, //is false
              //                       ),
              //               ),
              //             ),
              //           ),
              //         ));
              //   }).toList(),
              // ),
              SizedBox(height: 40),

              MyButton(
                  onTap: next,
                  buttontext: 'Next',
                  color: Colors.red,
                  textColor: Colors.black),
              SizedBox(height: 30),
            ],
          ),
        ));
  }
}
