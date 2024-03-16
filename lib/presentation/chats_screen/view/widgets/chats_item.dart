import 'package:flutter/material.dart';
import 'package:temp_house/app/extensions.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/text_styles.dart';

class ChatsItem extends StatelessWidget {
  const ChatsItem({super.key});

  @override
  Widget build(BuildContext context) {
    double width = context.width();
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.chatRoute);
      },
      child: ListTile(
        title: SizedBox(
          width: width * .45,
          child: Text(
            'Glanda',
            style: AppTextStyles.chatsScreenNameTextStyle(context),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          'Photo message',
          style: AppTextStyles.chatsScreenMessageTextStyle(context),
        ),
        leading: Container(
          width: width * .15,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            ImageAssets.personImage,
            filterQuality: FilterQuality.high,
          ),
        ),
        trailing: Container(
          width: width * .35,
          alignment: Alignment.centerRight,
          child: Text(
            'Today at 09.00 AM',
            style: AppTextStyles.chatsScreenDateTextStyle(context),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
