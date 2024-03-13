import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/main_button.dart';
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
          const SizedBox(
            height: 80,
          ),
          Row(
            children: [
              const SizedBox(
                width: 25,
              ),
              Text(
                AppStrings.registerScreenTitle.tr(),
                style: AppTextStyles.loginTitleTextStyle(context),
              ),
            ],
          ),
          Text(
            AppStrings.registerScreenSubTitle.tr(),
            style: AppTextStyles.splashScreenSubTitleTextStyle(context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: MainTextField(
              label: AppStrings.registerScreenUsernameLabel.tr(),
              isObscured: false,
              hint: AppStrings.registerScreenUsernameHint.tr(),
              textInputType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: MainTextField(
              label: AppStrings.registerScreenEmailLabel.tr(),
              isObscured: false,
              hint: AppStrings.registerScreenEmailHint.tr(),
              textInputType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: MainTextField(
              label: AppStrings.registerScreenPasswordLabel.tr(),
              isObscured: true,
              hint: AppStrings.registerScreenPasswordHint.tr(),
              iconData: Icons.remove_red_eye_outlined,
              textInputType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: MainTextField(
              label: AppStrings.registerScreenPhoneNumberLabel.tr(),
              isObscured: false,
              hint: AppStrings.registerScreenPhoneNumberHint.tr(),
              textInputType: TextInputType.phone,
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
            child: MainTextField(
              label: AppStrings.registerScreenJobLabel.tr(),
              isObscured: false,
              hint: AppStrings.registerScreenJobHint.tr(),
              textInputType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: MainTextField(
              label: AppStrings.registerScreenSalaryLabel.tr(),
              isObscured: false,
              hint: AppStrings.registerScreenSalaryHint.tr(),
              textInputType: TextInputType.phone,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: MainTextField(
              label: AppStrings.registerScreenAgeLabel.tr(),
              isObscured: false,
              hint: AppStrings.registerScreenAgeHint.tr(),
              textInputType: TextInputType.phone,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: MainTextField(
              label: AppStrings.registerScreenMartialStatusLabel.tr(),
              isObscured: false,
              hint: AppStrings.registerScreenMartialStatusHint.tr(),
              textInputType: TextInputType.text,
            ),
          ),
          const SizedBox(
            height: 30
          ),
          MainButton(
            text: AppStrings.registerScreenButton.tr(),
            textStyle: AppTextStyles.authButtonTextStyle(context),
            onTap: () {},
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: SocialContainer(
              title: AppStrings.registerScreenFacebook.tr(),
              image: SVGAssets.facebook,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: SocialContainer(
              title: AppStrings.registerScreenGoogle.tr(),
              image: SVGAssets.gmail,
            ),
          ),
        ],
      ),
    );
  }
}
