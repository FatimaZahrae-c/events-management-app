import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/navBarPages/chatButton/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class chatService extends ChangeNotifier {
  // get instance of auth and Firestore

  final FirebaseAuth firebaseauth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Send Message

  Future<void> sendMessage(String receiverId, String message) async {
    // get current user info
    final String currentUserId = firebaseauth.currentUser!.uid;
    final String currentUserEmail = firebaseauth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    // construct chat room
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    // add new message to database

    await firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // Get Messages

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    // construct chat room if from user ids
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
