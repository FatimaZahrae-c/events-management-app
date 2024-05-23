// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/navBarPages/UsersButton/Users.dart';
import 'package:events_app/navBarPages/addButton/Form1.dart';
import 'package:events_app/navBarPages/chatButton/chatUsers.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:events_app/navBarPages/profileButton/editProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  String loggedInUserId = FirebaseAuth.instance.currentUser!.uid;

  final String? title;
  final String? description;
  final String? detailedDescription;
  final String? date;
  final String? time;
  final String? location;
  final List<String>? invitedPeopleNames;
  final bool showCard;
  HomePage({
    Key? key,
    this.title,
    this.description,
    this.detailedDescription,
    this.date,
    this.time,
    this.location,
    this.invitedPeopleNames,
    required this.showCard,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedState = 'Current'; // Default selected state
  bool showCard = false;
  List<Map<String, dynamic>>? eventData;

  @override
  void initState() {
    super.initState();
    showCard = widget.showCard;
    getEventData();
  }

  void getEventData() async {
    String? userEmail = FirebaseAuth.instance.currentUser!.email;
    if (userEmail != null) {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('invitations')
          .where('invitedPersonEmail', isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          eventData = querySnapshot.docs.map((doc) => doc.data()).toList();
          showCard = true; // Affichez la carte si des données sont récupérées
        });
      } else {
        setState(() {
          eventData = null;
          showCard = false; // Masquez la carte si aucune donnée n'est récupérée
        });
      }
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  void archiveEvent() {
    setState(() {
      showCard = false;
      selectedState = 'Current';
    });
  }

  void viewCurrent() {
    setState(() {
      showCard = false;
      selectedState = 'Current';
    });
  }

  void viewArchived() {
    setState(() {
      showCard = true;
      selectedState = 'Archived';
    });
  }

  void add() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Form1()),
    );
  }

  void goToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(
                showCard: false,
              )),
    );
  }

  void goToUsers() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Users()),
    );
  }

  void goToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => editProfile()),
    );
  }

  void goToChat() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => chatUsers()),
    );
  }

  void showResultCard() {
    setState(() {
      showCard = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buildInvitationCards() {
      List<Widget> cards = [];
      if (eventData != null) {
        for (int i = 0; i < eventData!.length; i++) {
          String title = eventData![i]['title'] ?? '';
          String location = eventData![i]['location'] ?? '';
          String detailedDescription =
              eventData![i]['detailedDescription'] ?? '';
          List<String> invitedPeopleNames =
              List<String>.from(eventData![i]['invitedPeopleNames'] ?? []);
          String date = eventData![i]['date'] ?? '';
          String time = eventData![i]['time'] ?? '';

          cards.add(
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Slidable(
                startActionPane: ActionPane(motion: StretchMotion(), children: [
                  SlidableAction(
                    onPressed: (context) => archiveEvent(),
                    backgroundColor: Colors.blue.shade100,
                    icon: Icons.archive,
                  )
                ]),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(width: 70),
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
                      Align(
                        alignment: Alignment.topCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                // Show a message that the event has been accepted
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.greenAccent[700],
                                  content:
                                      Text('Invitation accepted successfully'),
                                ));
                              },
                              icon: Icon(Icons.check, color: Colors.green),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  eventData!.removeAt(i);
                                });
                              },
                              icon: Icon(Icons.close, color: Colors.red),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      }
      return cards;
    }

    // Display the card if showCard is true
    return Scaffold(
      backgroundColor: Color.fromARGB(244, 244, 245, 231),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(244, 244, 245, 231),
        toolbarHeight: 60,
        actions: [
          Text('Events',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
              )),
          SizedBox(width: 90),
          IconButton(
            onPressed: logout,
            icon: Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => viewCurrent(),
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 30,
                          top: 15,
                          bottom: 15,
                          right: 30,
                        ),
                        decoration: BoxDecoration(
                          color: selectedState == 'Current'
                              ? Colors.red
                              : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            'Current',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    GestureDetector(
                      onTap: () => viewArchived(),
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 30,
                          top: 15,
                          bottom: 15,
                          right: 30,
                        ),
                        decoration: BoxDecoration(
                          color: selectedState == 'Archived'
                              ? Colors.red
                              : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            'Archived',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              // Display the card if showCard is true
              if (showCard && eventData != null)
                Column(
                  children: buildInvitationCards(),
                )
              else
                // Afficher un contenu alternatif si showCard est faux ou si aucune donnée n'est disponible
                Column(
                  children: [
                    // Image centrée
                    Image.asset('lib/assets/emailphone.png', height: 300),
                    // Texte de création d'événement
                    Text(
                      "Let's create your first Event",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Description textuelle
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30.0, left: 30),
                        child: Text(
                          "Create your first event ! Click the button below to start your event planning journey.",
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: GNav(
            selectedIndex: 2,
            tabBackgroundColor: Colors.red,
            tabs: [
              GButton(
                icon: Icons.home,
                onPressed: goToHome,
              ),
              GButton(
                icon: Icons.people,
                onPressed: goToUsers,
              ),
              GButton(
                icon: Icons.add_circle_rounded,
                iconSize: 30,
                onPressed: add,
              ),
              GButton(
                icon: Icons.chat_rounded,
                onPressed: goToChat,
              ),
              GButton(
                icon: Icons.person,
                onPressed: goToProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
