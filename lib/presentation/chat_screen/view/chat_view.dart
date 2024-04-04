import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:temp_house/presentation/chat_screen/view/widgets/no_message_screen.dart';
import 'package:temp_house/presentation/chats_screen/auth_services.dart';
import 'package:temp_house/presentation/chat_screen/chat_service/chat_services.dart';
import 'package:temp_house/presentation/common/widget/main_circle_processIndicator.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../common/widget/main_app_bar.dart';

class ChatScreen extends StatefulWidget {
  final String receiveEmail;
  final String receiveID;

  const ChatScreen(
      {Key? key, required this.receiveEmail, required this.receiveID})
      : super(key: key);

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
          Text(
            widget.receiveEmail,
            style: AppTextStyles.paymentAppBarTextStyle(),
          )),
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
    ScrollController _scrollController = ScrollController();

    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _chatServices.getMessages(currentUserID, widget.receiveID),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return MainCicleProcessIndicator();
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return  NoContent(content: AppStrings.chatNoMessages.tr(),);
              }
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent);
              });
              return ListView.builder(
                controller: _scrollController,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final message =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  final isCurrentUser = message['senderID'] == currentUserID;
                  final messageText = message['message'];
                  final seen = message['seen'] ?? false;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppPadding.p4, horizontal: AppPadding.p8),
                    child: Align(
                      alignment: isCurrentUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: isCurrentUser
                              ? ColorManager.lightBlue
                              : ColorManager.lightGrey,
                          borderRadius: BorderRadius.circular(AppSize.s8),
                        ),
                        padding: const EdgeInsets.all(AppSize.s12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              messageText,
                              style:
                                  AppTextStyles.chatMessageTextStyle(context),
                            ),
                            const SizedBox(height: AppSize.s5),
                            Text(
                              _formatTimestamp(message['timestamp']),
                              style:
                                  AppTextStyles.chatTimpTimeTextStyle(context),
                            ),
                            if (isCurrentUser && seen)
                              const Icon(Icons.done_all,
                                  color: ColorManager.blue,
                                  size: AppSize.s20),
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
    return Column(
      children: [
        const Divider(color: ColorManager.offwhite,),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: AppMargin.m16, vertical: AppMargin.m20),
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                height: AppSize.s50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s20),
                    border: Border.all(color: ColorManager.grey)),
                child: TextField(
                  cursorColor: ColorManager.offwhite,
                  style: AppTextStyles.chatNoMessageTextStyle(context),
                  controller: _messageController,
                  decoration: InputDecoration.collapsed(
                      hintText: AppStrings.chatScreenInputHint.tr(),
                      hintStyle: AppTextStyles.chatTextFieldHintTextStyle(context)),
                ),
              ),
            ),
            IconButton(
              onPressed: () => _sendMessage(),
              icon: const Icon(
                Icons.send,
                size: AppSize.s40,
              ),
              color: ColorManager.white,
            ),
          ],
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
