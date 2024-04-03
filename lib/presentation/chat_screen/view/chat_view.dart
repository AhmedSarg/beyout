import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:temp_house/presentation/chats_screen/auth_services.dart';
import 'package:temp_house/presentation/chat_screen/chat_service/chat_services.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../common/widget/main_app_bar.dart';

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
      appBar: buildMainAppBar(
          context,
          Text(widget.receiveEmail,style: AppTextStyles.paymentAppBarTextStyle(),)
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
    ScrollController _scrollController = ScrollController(); // Create a ScrollController

    return Column( // Use Column instead of Flexible or Expanded
      children: [
        Expanded( // Wrap ListView.builder with Expanded to occupy remaining space
          child: StreamBuilder<QuerySnapshot>(
            stream: _chatServices.getMessages(currentUserID, widget.receiveID),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: ColorManager.grey,));
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No messages yet.'));
              }
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                _scrollController.jumpTo(_scrollController.position.maxScrollExtent); // Scroll to the end after the frame is built
              });
              return ListView.builder(
                controller: _scrollController, // Assign the ScrollController to the ListView
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final message = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  final isCurrentUser = message['senderID'] == currentUserID;
                  final messageText = message['message'];
                  final seen = message['seen'] ?? false; // Add null check here
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Align(
                      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: isCurrentUser ? Colors.blue[100] : Colors.grey[300],
                          borderRadius: BorderRadius.circular(AppSize.s8),
                        ),
                        padding: EdgeInsets.all(AppSize.s12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              messageText,
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(height: AppSize.s5),
                            Text(
                              _formatTimestamp(message['timestamp']),
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            if (isCurrentUser && seen)
                              Icon(Icons.done_all, color: Colors.blue, size: 16), // Display seen icon
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMessageInput() {

    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal:  AppMargin.m16,vertical: AppMargin.m20),
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: ColorManager.grey)
            ),
            child: TextField(

              controller: _messageController,

              decoration:  InputDecoration.collapsed(
                  hintText: AppStrings.chatScreenInputHint.tr(),
                  hintStyle: AppTextStyles.chatTextFieldHintTextStyle(context)
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () => _sendMessage(),
          icon: const Icon(Icons.send,size: AppSize.s40,),
          color: ColorManager.white,

        ),
      ],
    );
  }
  String _formatTimestamp(dynamic timestamp) {
    DateTime dateTime = (timestamp as Timestamp).toDate();
    return DateFormat('MMM d, h:mm a').format(dateTime);
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
