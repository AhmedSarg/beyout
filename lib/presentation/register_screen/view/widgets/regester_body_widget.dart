import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/main_btn_white.dart';
import '../../../common/widget/main_text_field.dart';
import '../../../common/widget/socialContainer.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(

        children: [
      SizedBox(height: 80,),
          Row(
            children: [
              SizedBox(width: 25,),
              Text(
                'Create Account',
                style: AppTextStyles.logintitleTextStyle(context),
              ),
            ],
          ),
          Text('Start booking with creating account',
              style: AppTextStyles.splashScreenSubTitleTextStyle(context)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: CommonTextField(
              text: 'User name',
              isObscured: false,
              hintText: 'Create your user name', textInputType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: CommonTextField(
              text: 'Email ',
              isObscured: false,
              hintText: 'Enter your email ', textInputType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child:    CommonTextField(
              text: AppStrings.loginScreenPassWordFieldLabel.tr(),
              isObscured: true,
              hintText: AppStrings.loginScreenPassWordFieldHint.tr(),
              iconData: Icons.remove_red_eye_outlined, textInputType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: CommonTextField(
              text: 'Phone Number ',
              isObscured: false,
              hintText: 'Enter Phone Number', textInputType: TextInputType.phone,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 16.0),
          //   child: CommonTextField(
          //     text: 'Gender',
          //     isObscured: false,
          //     hintText: 'Enter your Gender', textInputType: null,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: CommonTextField(
              text: 'Current Job ',
              isObscured: false,
              hintText: 'Create your Current Job', textInputType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: CommonTextField(
              text: 'Current Salary  ',
              isObscured: false,
              hintText: 'Create your Current Salary', textInputType: TextInputType.phone,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: CommonTextField(
              text: 'Age ',
              isObscured: false,
              hintText: 'Enter your Age ', textInputType: TextInputType.phone,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: CommonTextField(
              text: 'Marital status ',
              isObscured: false,
              hintText: 'Enter your marital status', textInputType: TextInputType.text,
            ),
          ),
          SizedBox(height: 30,),

          CommonBtn(title: 'Create Account',),
 SizedBox(height: 30,),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: SocialContainer(
                title: 'Sign up with facebook', image: SVGAssets.facebook),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: SocialContainer(
                title: 'Sign up with google', image: SVGAssets.gamil),
          ),

        ],
      ),
    );
  }
}
