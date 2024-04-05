import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';
import 'package:temp_house/presentation/chat_screen/chat_service/chat_services.dart';
import 'package:temp_house/presentation/chat_screen/view/chat_view.dart';
import 'package:temp_house/presentation/chats_screen/view/widgets/user_tile.dart';
import 'package:temp_house/presentation/common/widget/main_circle_processIndicator.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import '../../chat_screen/view/widgets/no_message_screen.dart';
import '../../common/widget/main_app_bar.dart';
import '../auth_services.dart';

class ChatsScreen extends StatelessWidget {
  ChatsScreen({Key? key}) : super(key: key);

  final ChatServices _chatServices = ChatServices();
  final AuthServices _authServices = AuthServices();

  void signOut(BuildContext context) {
    _authServices.signOut();
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
                icon: Icon(Icons.menu),
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
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _chatServices.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MainCicleProcessIndicator();
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return NoContent(content: AppStrings.chatNoUsers.tr());
        }

        final currentUserUID = _authServices.getCurrentUser()!.uid;
        final filteredUsers =
        snapshot.data!.where((user) => user['uid'] != currentUserUID).toList();

        return ListView.builder(
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            final userData = filteredUsers[index];
            return _buildUserListItem(userData, context);
          },
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authServices.getCurrentUser()!.email) {
      return UserTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return ChatScreen(
                receiveID: userData["uid"],
                receiveEmail: userData["email"],
              );
            }),
          );
        },
        text: userData["email"],
        lastMessage: userData["lastMessage"],
        lastMessageTime: _chatServices.formatTimestamp(userData["lastMessageTime"]),
      );
    } else {
      return Container();
    }
  }
}