import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/app/extensions.dart';

import '../../../common/widget/main_button.dart';
import '../../../common/widget/main_text_field.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    double height = context.height() / 1;
    bool keyboard = MediaQuery.of(context).viewInsets.bottom > 0;
    return Container(
      height: height,
      width: AppSize.infinity,
      color: ColorManager.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            AppStrings.forgotPasswordTitle.tr(),
            style: AppTextStyles.forgotPasswordTitleTextStyle(context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: MainTextField(
              label: null,
              isObscured: false,
              hint: AppStrings.forgotPasswordEmailValue.tr(),
              backgroundColor: ColorManager.darkGrey.withOpacity(.1),
              hintTextStyle: AppTextStyles.forgotPasswordEmailValueTextStyle(context),
              cursorColor: ColorManager.primary,
            ),
          ),
          keyboard ? const Spacer(flex: 2,) : const SizedBox(),
          const Divider(height: AppSize.s100),
          MainButton(
            text: AppStrings.forgotPasswordSendCode.tr(),
            onTap: () {},
            textStyle: AppTextStyles.forgotPasswordSendCodeTextStyle(context),
            backgroundColor: ColorManager.grey,
          ),
          Spacer(flex: keyboard ? 3 : 1),
        ],
      ),
    );
  }
}
