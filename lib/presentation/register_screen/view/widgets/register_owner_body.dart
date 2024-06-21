import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/validators/validators.dart';
import '../../../common/widget/main_button.dart';
import '../../../common/widget/main_text_field.dart';
import '../../../common/widget/register_field_dialog.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/register_viewmodel.dart';

class RegisterOwnerBody extends StatelessWidget {
  RegisterOwnerBody({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final RegisterViewModel viewModel;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode genderFocusNode = FocusNode();
  final FocusNode ageFocusNode = FocusNode();
  final FocusNode martialStatusFocusNode = FocusNode();

  final genderList = [
    AppStrings.registerScreenGenderMale.tr(),
    AppStrings.registerScreenGenderFemale.tr(),
  ];
  final martialStatusList = [
    AppStrings.registerScreenMartialStatusSingle.tr(),
    AppStrings.registerScreenMartialStatusMarried.tr(),
    AppStrings.registerScreenMartialStatusSeperated.tr(),
    AppStrings.registerScreenMartialStatusDivorced.tr(),
    AppStrings.registerScreenMartialStatusWidowed.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppPadding.p10,
        ),
        child: Column(
          children: [
            viewModel.getFireAuthUsername == null
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppPadding.p10),
                    child: MainTextField(
                      maxLines: 1,
                      controller: viewModel.getUsernameController,
                      focusNode: usernameFocusNode,
                      nextFocus: emailFocusNode,
                      label: AppStrings.registerScreenUsernameLabel.tr(),
                      validation: AppValidators.validateUsername,
                      isObscured: false,
                      hint: AppStrings.registerScreenUsernameHint.tr(),
                      textInputType: TextInputType.text,
                    ),
                  )
                : const SizedBox.shrink(),
            viewModel.getFireAuthEmail == null
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppPadding.p10),
                    child: MainTextField(
                      maxLines: 1,
                      controller: viewModel.getEmailController,
                      focusNode: emailFocusNode,
                      nextFocus: passwordFocusNode,
                      label: AppStrings.registerScreenEmailLabel.tr(),
                      isObscured: false,
                      validation: AppValidators.validateEmail,
                      hint: AppStrings.registerScreenEmailHint.tr(),
                      textInputType: TextInputType.emailAddress,
                    ),
                  )
                : const SizedBox.shrink(),
            viewModel.getFireAuthUser == null
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppPadding.p10),
                    child: MainTextField(
                      maxLines: 1,
                      controller: viewModel.getPasswordController,
                      focusNode: passwordFocusNode,
                      nextFocus: phoneNumberFocusNode,
                      label: AppStrings.registerScreenPasswordLabel.tr(),
                      isObscured: true,
                      validation: AppValidators.validatePassword,
                      hint: AppStrings.registerScreenPasswordHint.tr(),
                      iconData: Icons.remove_red_eye_outlined,
                      textInputType: TextInputType.text,
                    ),
                  )
                : const SizedBox.shrink(),
            viewModel.getFireAuthPhoneNumber == null
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppPadding.p10),
                    child: MainTextField(
                      maxLines: 1,
                      controller: viewModel.getPhoneNumberController,
                      focusNode: phoneNumberFocusNode,
                      nextFocus: genderFocusNode,
                      label: AppStrings.registerScreenPhoneNumberLabel.tr(),
                      isObscured: false,
                      validation: AppValidators.validatePhoneNumber,
                      hint: AppStrings.registerScreenPhoneNumberHint.tr(),
                      textInputType: TextInputType.phone,
                    ),
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: MainTextField(
                maxLines: 1,
                controller: viewModel.getGenderController,
                focusNode: genderFocusNode,
                nextFocus: ageFocusNode,
                label: AppStrings.registerScreenGenderLabel.tr(),
                isObscured: false,
                readOnly: true,
                hint: AppStrings.registerScreenGenderHint.tr(),
                validation: AppValidators.validateGender,
                textInputType: TextInputType.text,
                onTap: () {
                  showRegisterDialog(
                    context,
                    onSelect: (v) {
                      viewModel.getGenderController.text = v;
                    },
                    title: AppStrings.registerScreenGenderLabel.tr(),
                    items: genderList,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: MainTextField(
                maxLines: 1,
                controller: viewModel.getAgeController,
                focusNode: ageFocusNode,
                label: AppStrings.registerScreenAgeLabel.tr(),
                isObscured: false,
                validation: AppValidators.validateAge,
                hint: AppStrings.registerScreenAgeHint.tr(),
                textInputType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p30),
              child: MainButton(
                text: AppStrings.registerScreenButton.tr(),
                textStyle: AppTextStyles.authButtonTextStyle(context),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    viewModel.register();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
