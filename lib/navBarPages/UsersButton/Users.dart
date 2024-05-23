// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/navBarPages/chatButton/UserDisplay.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Users extends StatefulWidget {
  const Users({Key? key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
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
            'Users',
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
        child: buildUserList(),
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

    return UserDisplay(
      ontap: () {},
      text: data['email'],
    );
  }
}
