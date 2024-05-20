import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:temp_house/app/extensions.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/langauge_manager.dart';

import '../../../chat_screen/view/chat_view.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';

class ChatsItem extends StatelessWidget {
  const ChatsItem({
    super.key,
    required this.chatId,
    required this.personId,
    required this.name,
    required this.lastMessage,
    required this.lastMessageDate,
  });

  final String chatId;
  final String personId;
  final String name;
  final String lastMessage;
  final DateTime lastMessageDate;

  @override
  Widget build(BuildContext context) {
    print(lastMessageDate.difference(DateTime.now()).inDays);
    double width = context.width();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ChatScreen(
                receiveID: personId,
                receiveEmail: name,
                chatID: chatId,
              );
            },
          ),
        );
      },
      child: ListTile(
        title: SizedBox(
          width: width * .45,
          child: Text(
            name,
            style: AppTextStyles.chatsScreenNameTextStyle(context),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          lastMessage,
          style: AppTextStyles.chatsScreenMessageTextStyle(context),
          overflow: TextOverflow.ellipsis,
        ),
        leading: Container(
          width: AppSize.s60,
          height: AppSize.s60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.asset(ImageAssets.unknownUserImage),
        ),
        trailing: Container(
          width: width * .35,
          alignment:
              AppLanguages.getCurrentTextDirection(context) == TextDirection.rtl
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
          child: Text(
            lastMessageDate.difference(DateTime.now()).inDays == 0
                ? 'Today at ${DateFormat('hh:mm a').format(lastMessageDate)}'
                : lastMessageDate.difference(DateTime.now()).inDays == -1
                    ? 'Yesterday at ${DateFormat('hh:mm a').format(lastMessageDate)}'
                    : lastMessageDate.difference(DateTime.now()).inDays >= -7
                        ? DateFormat('EEE \'at\' hh:mm a')
                            .format(lastMessageDate)
                        : DateFormat('MMM dd, hh:mm a').format(lastMessageDate),
            style: AppTextStyles.chatsScreenDateTextStyle(context),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
