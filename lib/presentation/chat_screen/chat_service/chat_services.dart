import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(
      String receiverId,
      String content,
      String type,
      String currentUserID,
      String currentUserEmail,
      Timestamp timestamp,
      ) async {
    Map<String, dynamic> messageData = {
      'senderID': currentUserID,
      'senderEmail': currentUserEmail,
      'receiverID': receiverId,
      'content': content,
      'timestamp': timestamp,
      'type': type,
      'seen': false,
    };

    List<String> ids = [currentUserID, receiverId];
    ids.sort();
    String chatRoomID = ids.join('_');

    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection('messages')
        .add(messageData);
  }

  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      snapshot.docs.forEach((doc) {
        if (doc['receiverID'] == userID) {
          doc.reference.update({'seen': true});
        }
      });
      return snapshot;
    });
  }
}
