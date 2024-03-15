import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/main_button.dart';
import '../../../common/widget/main_text_field.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import 'reset_success.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(

          bottom: MediaQuery.of(context).viewInsets.bottom
      ),
      child: Container(
        height: MediaQuery.of(context).size.height*.7,
        width: AppSize.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                AppStrings.resetPasswordTitle.tr(),
                style: AppTextStyles.resetPasswordTitleTextStyle(context),
              ),
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: MainTextField(
                  label: null,
                  readOnly: true,
                  hint: AppStrings.resetPasswordEmailValue.tr(),
                  backgroundColor: ColorManager.darkGrey.withOpacity(.1),
                  hintTextStyle: AppTextStyles.resetPasswordEmailValueTextStyle(context),
                ),
              ),

              const Divider(height: AppSize.s50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: MainTextField(
                  isObscured: true,
                  label: AppStrings.resetPasswordPasswordLabel.tr(),
                  hint: AppStrings.resetPasswordPasswordHint.tr(),
                  backgroundColor: ColorManager.darkGrey.withOpacity(.1),
                  hintTextStyle: AppTextStyles.resetPasswordPasswordHintTextStyle(context),
                  cursorColor: ColorManager.primary,
                  labelTextStyle: AppTextStyles.resetPasswordPasswordLabelTextStyle(context),
                ),
              ),
              const SizedBox(height: 15,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: MainTextField(
                  isObscured: true,
                  label: AppStrings.resetPasswordConfirmLabel.tr(),
                  hint: AppStrings.resetPasswordPasswordHint.tr(),
                  backgroundColor: ColorManager.darkGrey.withOpacity(.1),
                  hintTextStyle: AppTextStyles.resetPasswordPasswordHintTextStyle(context),
                  cursorColor: ColorManager.primary,
                  labelTextStyle: AppTextStyles.resetPasswordPasswordLabelTextStyle(context),
                ),
              ),
              const SizedBox(height: 15,),

              MainButton(
                text: AppStrings.resetPasswordChange.tr(),
                onTap: () {
                  Navigator.pop(context);
                  showModalBottomSheet(context: context, builder: (context) => const ResetSuccess());
                },
                textStyle: AppTextStyles.resetPasswordChangeTextStyle(context),
                backgroundColor: ColorManager.grey,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
