import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String content; // Changed from 'message' to 'content'
  final Timestamp timestamp;
  final String type; // Added type field
  bool seen;

  Message(this.senderID, this.senderEmail, this.receiverID, this.content, this.timestamp, this.type, this.seen); // Updated constructor to include 'type'

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'receiverID': receiverID,
      'content': content,
      'timestamp': timestamp,
      'type': type, // Added 'type' to map
      'seen': seen,
    };
  }
}
