import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/main_button.dart';
import '../../../common/widget/main_text_field.dart';
import '../../../common/widget/social_container.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import 'forgot_password.dart';

class LoginBody extends StatelessWidget {
  LoginBody({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppSize.s50,
        ),
        child: Column(
          children: [
            MainTextField(
              label: AppStrings.loginScreenEmailLabel.tr(),
              isObscured: false,
              hint: AppStrings.loginScreenEmailHint.tr(),
              textInputType: TextInputType.text,
            ),
            const SizedBox(height: AppSize.s20),
            MainTextField(
              label: AppStrings.loginScreenPasswordLabel.tr(),
              isObscured: true,
              hint: AppStrings.loginScreenPasswordHint.tr(),
              iconData: Icons.remove_red_eye_outlined,
              textInputType: TextInputType.text,
            ),
            const SizedBox(height: AppSize.s20),
            Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Form(
                          key: _formKey,
                          child: ForgotPassword(
                            formKey: _formKey,
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    AppStrings.loginScreenForgotPassword.tr(),
                    style: AppTextStyles.authActionsTextStyle(context),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.registerRoute);
                  },
                  child: Text(
                    AppStrings.loginScreenCreateAccount.tr(),
                    style: AppTextStyles.authActionsTextStyle(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s50),
            Center(
              child: MainButton(
                text: AppStrings.loginScreenButton.tr(),
                onTap: () {},
                textStyle: AppTextStyles.authButtonTextStyle(context),
              ),
            ),
            const SizedBox(height: AppSize.s50),
            Center(
              child: Column(
                children: [
                  SocialContainer(
                    title: AppStrings.loginScreenFacebook.tr(),
                    image: SVGAssets.facebook,
                  ),
                  const SizedBox(height: AppSize.s10),
                  SocialContainer(
                    title: AppStrings.loginScreenGoogle.tr(),
                    image: SVGAssets.gmail,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
