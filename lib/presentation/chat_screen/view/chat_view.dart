import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:temp_house/presentation/chats_screen/auth_services.dart';
import 'package:temp_house/presentation/chat_screen/chat_service/chat_services.dart';

class ChatScreen extends StatefulWidget {
  final String receiveEmail;
  final String receiveID;

  const ChatScreen({Key? key, required this.receiveEmail, required this.receiveID}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final AuthServices _authServices = AuthServices();
  final ChatServices _chatServices = ChatServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiveEmail),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String currentUserID = _authServices.getCurrentUser()!.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: _chatServices.getMessages(currentUserID, widget.receiveID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No messages yet.'));
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final message = snapshot.data!.docs[index].data() as Map<String, dynamic>;
            final isCurrentUser = message['senderID'] == currentUserID;
            return ListTile(
              title: Text(message['message']),
              subtitle: Text(isCurrentUser ? 'You' : widget.receiveEmail),

              contentPadding: EdgeInsets.symmetric(horizontal: isCurrentUser ? 60.0 : 0.0),
              tileColor: isCurrentUser ? Colors.blue[100] : Colors.grey[200],
            );
          },
        );
      },
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type message...',
              ),
            ),
          ),
          IconButton(
            onPressed: () => _sendMessage(),
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    String message = _messageController.text.trim();
    if (message.isNotEmpty) {
      String currentUserID = _authServices.getCurrentUser()!.uid;
      await _chatServices.sendMessage(widget.receiveID, message);
      _messageController.clear();
    }
  }
}
