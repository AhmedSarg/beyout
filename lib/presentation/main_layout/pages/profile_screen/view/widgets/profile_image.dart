
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return   Container(
      margin: EdgeInsets.symmetric(horizontal: AppMargin.m20),
      decoration: BoxDecoration(
        color: ColorManager.primary.withOpacity(.9),
        borderRadius: BorderRadius.circular(AppSize.s10)
      ),
      child: ListTile(
        trailing: Icon(Icons.arrow_forward_ios,color: ColorManager.grey,),
        title: Text('Nilson Jackson',style: AppTextStyles.profileinfoNameTextStyle(context),),
        subtitle: Text('Nilson.Jackson11@gmail.com',style: AppTextStyles.profileinfoEmailTextStyle(context),),
        leading: const CircleAvatar(
            radius: 50,
            child: Icon(Icons.person)),
      ),
    );
  }
}