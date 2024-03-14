import 'package:flutter/material.dart';
import 'package:temp_house/presentation/chat_screen/view/widgets/person_item.dart';

class ChatScreenBody extends StatelessWidget {
  const ChatScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
return PersonItem();
    },);
  }
}
