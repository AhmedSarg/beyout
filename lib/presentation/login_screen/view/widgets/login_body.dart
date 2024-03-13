import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/main_button.dart';
import '../../../common/widget/main_text_field.dart';
import '../../../common/widget/socialContainer.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import 'divider.dart';
import 'forgot_password.dart';

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
              const SizedBox(width: 60),
              Text(
                AppStrings.loginScreenTitle.tr(),
                style: AppTextStyles.loginTitleTextStyle(context),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Line(),
          const SizedBox(height: 35),
          MainTextField(
            text: AppStrings.loginScreenEmailLabel.tr(),
            isObscured: false,
            hintText: AppStrings.loginScreenEmailHint.tr(),
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 15),
          MainTextField(
            text: AppStrings.loginScreenPasswordLabel.tr(),
            isObscured: true,
            hintText: AppStrings.loginScreenPasswordHint.tr(),
            iconData: Icons.remove_red_eye_outlined,
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.loginScreenForgotPassword.tr(),
                    style: AppTextStyles.authActionsTextStyle(context),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.loginScreenCreateAccount.tr(),
                    style: AppTextStyles.authActionsTextStyle(context),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Center(
            child: MainButton(
              text: AppStrings.loginScreenButton.tr(),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const ForgotPassword(),
                );
              },
              textStyle: AppTextStyles.authButtonTextStyle(context),
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: Column(
              children: [
                SocialContainer(
                  title: AppStrings.loginScreenFacebook.tr(),
                  image: SVGAssets.facebook,
                ),
                const SizedBox(height: 10),
                SocialContainer(
                  title: AppStrings.loginScreenGoogle.tr(),
                  image: SVGAssets.gmail,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
