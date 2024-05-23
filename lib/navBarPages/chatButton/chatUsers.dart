// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/navBarPages/chatButton/UserDisplay.dart';
import 'package:events_app/navBarPages/chatButton/chatPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class chatUsers extends StatefulWidget {
  const chatUsers({Key? key});

  @override
  State<chatUsers> createState() => _chatUsersState();
}

class _chatUsersState extends State<chatUsers> {
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(244, 244, 245, 231),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(244, 244, 245, 231),
        toolbarHeight: 80,
        actions: [
          Text(
            'Chats',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
            ),
          ),
          SizedBox(width: 100),
          IconButton(
            onPressed: logout,
            icon: Icon(Icons.logout_outlined),
          ),
          SizedBox(height: 40),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 48.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Icon(
                Icons.message,
                size: 70,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: buildUserList(),
            ),
          ],
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
              .map<Widget>((doc) => buildUserListItem(doc, context))
              .toList(),
        );
      },
    );
  }

  Widget buildUserListItem(DocumentSnapshot document, BuildContext context) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // Get the ID of the current user if available
    String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

    // Check if the current user ID is available and if it matches the document's ID
    if (currentUserId != null && document.id == currentUserId) {
      // Skip rendering the current user
      return SizedBox.shrink();
    }

    // Check if email is null
    String? email = data['email'];

    // Render UserDisplay only if email is not null
    if (email != null) {
      return UserDisplay(
        ontap: () {
          // Pass the clicked user's UID to the chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => chatPage(
                receiverUserEmail: email,
                receiverUserId: data['uid'],
              ),
            ),
          );
        },
        text: email,
      );
    } else {
      // Return an empty SizedBox if email is null
      return SizedBox.shrink();
    }
  }
}
