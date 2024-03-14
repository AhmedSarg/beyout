import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/chat_screen/view/widgets/chat_screen_body.dart';

import '../../common/widget/main_app_bar.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_styles.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(
        context,
        Text(
          'Chat Box',
          style: AppTextStyles.loginTitleTextStyle(context),
        ),
      ),
      body:ChatScreenBody() ,
    );
  }
}
