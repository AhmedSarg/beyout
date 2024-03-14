import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/text_styles.dart';

class PersonItem extends StatelessWidget {
  const PersonItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
    );
  }
}
