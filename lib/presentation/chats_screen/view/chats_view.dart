import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/app/constants.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';
import 'package:temp_house/presentation/chat_screen/chat_service/chat_services.dart';
import 'package:temp_house/presentation/chat_screen/view/chat_view.dart';
import 'package:temp_house/presentation/chats_screen/view/widgets/user_tile.dart';
import 'package:temp_house/presentation/common/widget/main_circle_processIndicator.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import '../../chat_screen/view/widgets/no_message_screen.dart';
import '../../common/data_intent/data_intent.dart';
import '../../common/widget/main_app_bar.dart';

class ChatsScreen extends StatelessWidget {
  ChatsScreen({Key? key}) : super(key: key);

  final ChatServices _chatServices = ChatServices();

  void signOut(BuildContext context) {
    // _authServices.signOut();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => signOut(context),
                icon: const Icon(Icons.menu),
              ),
            ],
          ),
        ),
      ),
      appBar: buildMainAppBar(
        context,
        Text(
          AppStrings.chatsScreenTitle.tr(),
          style: AppTextStyles.chatsScreenTitleTextStyle(context),
        ),
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _chatServices.getUserStreamOrdered(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MainCicleProcessIndicator();
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return NoContent(content: AppStrings.chatNoUsers.tr());
        }
        final filteredUsers = snapshot.data!.docs;

        return ListView.builder(
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            final userData = filteredUsers[index].data();
            return _buildUserListItem(
                userData, context, filteredUsers[index].id);
          },
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context, String id) {
    // if (userData["email"] != _authServices.getCurrentUser()!.email) {
    // String lastMessage = userData["lastMessage"];
    // String text = lastMessage.contains(Constants.show_sendimage) ? AppStrings.chatSendImage.tr() : userData["lastMessage"];

    userData["participants_names"].remove(DataIntent.getUser().name);
    userData["participants_ids"].remove(DataIntent.getUser().uid);
    return UserTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ChatScreen(
              receiveID: userData["participants_ids"].first,
              receiveEmail: userData["participants_names"].first, chatID: id,
            );
          }),
        );
      },
      text: userData["participants_names"].first,
      // lastMessage: text,
      lastMessageTime:
          _chatServices.formatTimestamp(userData["last_message_time"]),
      lastMessage: userData['last_message'],
    );
    // } else {
    //   return Container();
    // }
  }
}
