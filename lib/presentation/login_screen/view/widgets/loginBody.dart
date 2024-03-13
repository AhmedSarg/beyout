import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/common/widget/main_text_field.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';

import '../../../common/widget/main_btn_white.dart';
import '../../../common/widget/main_btn_transpirant.dart';
import '../../../common/widget/socialContainer.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import 'divider.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .12,
          ),
          Row(
            children: [
              const SizedBox(
                width: 60,
              ),
              Text(
                AppStrings.loginScreenTitle.tr(),
                style: AppTextStyles.logintitleTextStyle(context),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Line(),
          const SizedBox(
            height: 35,
          ),
          CommonTextField(
            text: AppStrings.loginScreenEmailFieldLabel.tr(),
            isObscured: false,
            hintText: AppStrings.loginScreenEmailFieldHint.tr(),
          ),
          const SizedBox(
            height: 15,
          ),
          CommonTextField(
            text: AppStrings.loginScreenPassWordFieldLabel.tr(),
            isObscured: true,
            hintText: AppStrings.loginScreenPassWordFieldHint.tr(),
            iconData: Icons.remove_red_eye_outlined,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: TextButton(
                  onPressed: () {},
                  child: Text('Forgot Password',
                      style: AppTextStyles.authSpeachialTextStyle(context)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Spacer(),
              InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      'Create Account',
                      style: AppTextStyles.authSpeachialTextStyle(context),
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
              child: CommonBtnTransperant(
            title: 'Login',
          )),
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: Column(
              children: [
                SocialContainer(
                  title: 'Sign up with google',
                  image: SVGAssets.facebook,
                ),
                SizedBox(
                  height: 10,
                ),
                SocialContainer(
                    title: 'Sign up with facebook', image: SVGAssets.gamil),
              ],
            ),
          )
        ],
      ),
    );
  }
}
