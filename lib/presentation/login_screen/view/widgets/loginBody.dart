import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/common/widget/main_text_field.dart';
import 'package:temp_house/presentation/login_screen/view/widgets/textFiled.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';

import 'divider.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height*.12,),
        Row(
          children: [
            const SizedBox(width: 60,),
            Text(AppStrings.loginScreenTitle.tr(),style: AppTextStyles.logintitleTextStyle(context),),
          ],
        ),
        const SizedBox(height: 15,),
        const Line(),
        CommonTextField(text: 'Email', isObscured: true, hintText: 'Enter your email',),
        const SizedBox(height: 15,),
        CommonTextField(text: 'Password', isObscured: false, hintText: 'Create your password',),


      ],
    );
  }
}
