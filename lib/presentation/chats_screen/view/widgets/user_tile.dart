import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          child: Row(
            children: [
              CircleAvatar(radius: 30, child: Icon(Icons.person)),
              SizedBox(width: AppSize.s10,),
              Text(
                text,
                style: AppTextStyles.chatsScreenTitleTextStyle(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
