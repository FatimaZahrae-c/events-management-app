// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/components/MyButton.dart';
import 'package:events_app/pages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class result extends StatelessWidget {
  result({
    super.key,
    required this.title,
    required this.description,
    required this.detailedDescription,
    required this.date,
    required this.time,
    required this.location,
    required this.invitedPeopleNames,
    required this.onSend,
  });
  final VoidCallback onSend;

  final String title;

  final String description;

  final String detailedDescription;

  final String date;

  final String time;

  final String location;

  final List<String> invitedPeopleNames;

  @override
  Widget build(BuildContext context) {
    void logout() {
      FirebaseAuth.instance.signOut();
    }

    void send(BuildContext context) {
      String currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
      // Include the current user's email along with the invited people's emails
      List<String> allInvitedEmails = List.from(invitedPeopleNames)
        ..add(currentUserEmail);

      // Update Firestore with event details for each invited person
      allInvitedEmails.forEach((email) {
        FirebaseFirestore.instance.collection('invitations').add({
          'title': title,
          'description': description,
          'detailedDescription': detailedDescription,
          'date': date,
          'time': time,
          'location': location,
          'invitedPersonEmail': email,
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey.shade700,
          content: SizedBox(
            height: 20,
            child: Center(
              child: Text(
                'The event is saved',
                style: TextStyle(
                    color: Colors.white, fontSize: 20, fontFamily: 'Poppins'),
              ),
            ),
          ),
          action: SnackBarAction(
            textColor: Colors.black,
            label: 'Click here to see it',
            onPressed: () {
              // Navigate to HomePage when the action is clicked
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    title: title,
                    description: description,
                    detailedDescription: detailedDescription,
                    date: date,
                    time: time,
                    location: location,
                    invitedPeopleNames: invitedPeopleNames,
                    showCard: true,
                    
                  ),
                ),
              );
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
              percent: 1,
              backgroundColor: Colors.red.shade100,
            ),
            SizedBox(height: 100),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Card(
                  elevation: 20,
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Icon(
                            Icons.star_rate_outlined,
                            size: 40,
                            color: Colors.red,
                          ),
                        ),
                        title: Text(
                          ' $title , $location',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
                        ),
                        subtitle: Text('$detailedDescription'),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(left: 100.0),
                        child: Row(
                          children: [
                            Icon(Icons.check_box, size: 20),
                            const SizedBox(width: 5),
                            Text(
                              'Guests:',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: invitedPeopleNames
                            .map((name) => Text(
                                  '- $name',
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '$date',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 25),
                          Icon(
                            Icons.alarm,
                            size: 16,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '$time',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                      const SizedBox(height: 6),
                    ],
                  )),
            ),

            SizedBox(height: 18),

            MyButton(
                onTap: () => send(context),
                buttontext: 'Send',
                color: Colors.black,
                textColor: Colors.white)
          ],
        ),
      ),
    );
  }
}
