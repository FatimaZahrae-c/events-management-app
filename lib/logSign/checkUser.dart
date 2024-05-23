import 'package:events_app/logSign/login_page.dart';

import 'package:events_app/pages/HomePage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//check if the user is signed in or not
class checkUser extends StatelessWidget {
  const checkUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      // StreamBuilder listens to the stream, and whenever new data is received, it calls the builder with the updated data
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //user logged in
        if (snapshot.hasData) {
          print("ok");
          return HomePage(
            showCard: false,
          );
        }

        // user not logged in

        else {
          return login_page();
        }
      },
    ));
  }
}
