import 'package:flutter/material.dart';
import 'package:temp_house/presentation/chats_screen/view/widgets/user_tile.dart';
import '../../chat_screen/chat_service/chat_services.dart';
import '../../chat_screen/view/chat_view.dart';
import '../auth_services.dart';


class ChatsScreen extends StatelessWidget {
  ChatsScreen({Key? key}) : super(key: key);

  final ChatServices _chatServices = ChatServices();
  final AuthServices _authServices = AuthServices();

  void signOut(BuildContext context) {
    _authServices.signOut();
    Navigator.pop(context); // Close drawer after sign-out
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
                onPressed: () => signOut(context), // Pass context to signOut
                icon: Icon(Icons.menu),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _chatServices.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No users found.'));
        }

        // Get current user UID
        final currentUserUID = _authServices.getCurrentUser()!.uid;

        // Filter out the current user's data
        final filteredUsers = snapshot.data!.where((user) => user['uid'] != currentUserUID).toList();

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
      );
    } else {
      return Container();
    }
  }
}
