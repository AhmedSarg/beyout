import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail; // Changed to camelCase for consistency
  final String receiverID;
  final String message;
  final Timestamp timestamp; // Using Timestamp from cloud_firestore

  Message(this.senderID, this.senderEmail, this.receiverID, this.message, this.timestamp);

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail, // Corrected the key to camelCase
      'receiverID': receiverID,
      'message': message,
      'timestamp': timestamp, // Changed 'Timestamp' to 'timestamp'
    };
  }
}
