import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/validators/validators.dart';
import '../../../common/widget/main_button.dart';
import '../../../common/widget/main_text_field.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import 'reset_password.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppPadding.p16,
        right: AppPadding.p16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .45,
        width: AppSize.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: AppSize.s60),
            Text(
              AppStrings.forgotPasswordTitle.tr(),
              style: AppTextStyles.forgotPasswordTitleTextStyle(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: MainTextField(
                label: null,
                validation: AppValidators.validateEmailResetPassword,
                hint: AppStrings.forgotPasswordEmailValue.tr(),
                backgroundColor: ColorManager.darkGrey.withOpacity(.1),
                hintTextStyle:
                    AppTextStyles.forgotPasswordEmailValueTextStyle(context),
                cursorColor: ColorManager.primary.withOpacity(.3),
              ),
            ),
            const Divider(height: AppSize.s100),
            MainButton(
              text: AppStrings.forgotPasswordSendCode.tr(),
              onTap: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const ResetPassword(),
                  );
                }
              },
              textStyle: AppTextStyles.forgotPasswordSendCodeTextStyle(context),
              backgroundColor: ColorManager.grey,
            ),
          ],
        ),
      ),
    );
  }
}
