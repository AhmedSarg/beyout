import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;
  final String phoneNumber;
  final String addres;
  final String description;

  PlaceModel(
      this.id,
      this.name,
      this.latLng,
      this.phoneNumber,
      this.addres,
      this.description,
      );
}



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

class User {
  final String uid;
  final String email;
  final String name;

  User({
    required this.uid,
    required this.email,
    required this.name,
  });
}


