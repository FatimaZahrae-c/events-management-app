// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:events_app/navBarPages/chatButton/chatBubble.dart';
import 'package:events_app/navBarPages/chatButton/chatService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class chatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserId;
  const chatPage({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserId,
  });

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  final TextEditingController messageController = TextEditingController();
  final chatService _chatService = chatService();
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserId, messageController.text);
      // Effacez le texte du contrôleur après avoir envoyé le message
      messageController.clear();
      // Déclencher la mise à jour de l'interface utilisateur
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    void logout() {
      FirebaseAuth.instance.signOut();
    }

    return Scaffold(
        // backgroundColor: Color.fromARGB(244, 244, 245, 231),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(244, 244, 245, 231),
          toolbarHeight: 80,
          actions: [
            Text(
              widget.receiverUserEmail,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
              ),
            ),
            SizedBox(width: 40),
            IconButton(
              onPressed: logout,
              icon: Icon(Icons.logout_outlined),
            ),
          ],
        ),
        body: Column(
          children: [
            //messages
            Expanded(
              child: buildMessageList(),
            ),

            //user input
            buildMessageInput(),
          ],
        ));
  }

  // build message list

  Widget buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getMessages(
          widget.receiverUserId, firebaseauth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }
        // Récupérez la liste des documents
        final List<DocumentSnapshot> messages = snapshot.data!.docs;
        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            // Construisez chaque élément de message
            return buildMessageItem(messages[index]);
          },
        );
      },
    );
  }

  Widget buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

    if (data == null) {
      return SizedBox(); // Placeholder widget, you can customize this
    }

    var senderEmail = data['senderEmail'] as String?;
    var message = data['message'] as String?;

    // Align the messages based on the sender
    var alignment = (data['senderId'] == firebaseauth.currentUser!.uid
        ? Alignment.centerRight
        : Alignment.centerLeft);

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == firebaseauth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          children: [
            Text(senderEmail ?? ""), // Add null check here
            SizedBox(height: 6),
            chatBubble(
              message: message ?? "", // Add null check here
            )
          ],
        ),
      ),
    );
  }

  // build message input
  Widget buildMessageInput() {
    return Row(
      children: [
        //textfield

        Expanded(
          child: Padding(
              padding: const EdgeInsets.only(bottom: 18.0, left: 16),
              child: TextField(
                controller: messageController,
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
                    hintText: 'Enter message',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                    )),
              )),
        ),

        // send button

        Padding(
          padding: const EdgeInsets.only(left: 18.0, bottom: 18),
          child: IconButton(
            onPressed: sendMessage,
            icon: Icon(Icons.send, size: 40, color: Colors.red),
          ),
        )
      ],
    );
  }
}
