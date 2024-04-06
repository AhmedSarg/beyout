import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String content;
  final Timestamp timestamp;
  final String type;
  bool seen;

  Message(this.senderID, this.senderEmail, this.receiverID, this.content, this.type, this.seen, this.timestamp); // Updated constructor to include 'type'

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'receiverID': receiverID,
      'content': content,
      'timestamp': timestamp,
      'type': type,
      'seen': seen,
    };
  }
}
