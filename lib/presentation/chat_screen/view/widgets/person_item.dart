import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp_house/presentation/resources/routes_manager.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/text_styles.dart';

class PersonItem extends StatelessWidget {
  const PersonItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.chatDetailsRoute);
      },
      child: ListTile(
        title: Text('Glanda', style: AppTextStyles.personNameTextStyle(context),),
        subtitle: Text(
          'Photo message',
          style: AppTextStyles.messageTextStyle(context),
        ),
        leading: Image.asset(ImageAssets.personImage,filterQuality: FilterQuality.high),
        trailing:Text(
          'Today at 09.00 AM',
          style: AppTextStyles.chatDateTextStyle(context),
        ) ,
      ),
    );
  }
}
class ChatScreendetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
        ),
        body: ChatBody(),
      ),
    );
  }
}

class ChatBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 10, // number of messages
            itemBuilder: (context, index) {
              // In a real application, you'd fetch messages from a database or API
              return ChatMessage(
                message: 'Message $index',
                isSentByMe: index % 2 == 0, // alternate between sent and received
              );
            },
          ),
        ),
        ChatInput(),
      ],
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  const ChatMessage({
    required this.message,
    required this.isSentByMe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isSentByMe ? Colors.white : Colors.black,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}

class ChatInput extends StatefulWidget {
  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      color: Colors.grey[200],
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              // Handle sending message
              print(_textController.text);
              _textController.clear();
            },
          ),
        ],
      ),
    );
  }
}