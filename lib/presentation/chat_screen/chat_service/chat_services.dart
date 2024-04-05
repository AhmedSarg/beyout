import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

class ChatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return {
          ...user,
          'lastMessage': user['lastMessage'] ?? '',
          'lastMessageTime': user['lastMessageTime'] ?? '',
        };
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
    String chatRoomID = getChatRoomID(currentUserID, receiverId);

    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection('messages')
        .add(messageData);

    // Update sender's last message
    await _firestore.collection("Users").doc(currentUserID).update({
      'lastMessage': content,
      'lastMessageTime': timestamp,
    });

    // Update receiver's last message
    await _firestore.collection("Users").doc(receiverId).update({
      'lastMessage': content,
      'lastMessageTime': timestamp,
    });
  }

  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    String chatRoomID = getChatRoomID(userID, otherUserID);
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

  String getChatRoomID(String currentUserID, String otherUserID) {
    List<String> ids = [currentUserID, otherUserID];
    ids.sort();
    return ids.join('_');
  }

  String formatTimestamp(dynamic timestamp) {
    DateTime dateTime = (timestamp as Timestamp).toDate();
    return DateFormat('MMM d, h:mm a').format(dateTime);
  }
}