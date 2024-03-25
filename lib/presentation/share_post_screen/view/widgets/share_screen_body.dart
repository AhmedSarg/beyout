import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:temp_house/presentation/share_post_screen/view/widgets/share_text_field.dart';

import '../../../common/validators/validators.dart';
import '../../../common/widget/main_button.dart';
import '../../../common/widget/main_text_field.dart';
import '../../../common/widget/register_field_dialog.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/share_view_model.dart';
import 'image_picker.dart';

class SharePostScreenBody extends StatefulWidget {
  SharePostScreenBody({
    super.key,
    required this.viewModel,
  });
  final ShareViewModel viewModel;

  @override
  State<SharePostScreenBody> createState() => _SharePostScreenBodyState();
}

class _SharePostScreenBodyState extends State<SharePostScreenBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode titleFocusNode = FocusNode();

  final FocusNode priceFocusNode = FocusNode();

  final FocusNode locationFocusNode = FocusNode();

  final FocusNode categoryFocusNode = FocusNode();

  final FocusNode condationFocusNode = FocusNode();

  final FocusNode descriptionFocusNode = FocusNode();
  final categoryList = [
    '1000',
    '2000',
    '3000',
    '4000',
    '5000',
  ];
  final CondationList = [
    '1000',
    '2000',
    '3000',
    '4000',
    '5000',

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
            const Padding(
              padding: EdgeInsets.symmetric(vertical:  AppPadding.p10),
              child: ImagePickerField(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: searchTextField(
                controller: widget.viewModel.getTitleController,
                focusNode: titleFocusNode,
                nextFocus: priceFocusNode,
                validation: AppValidators.validateUsername,
                isObscured: false,
                hint: AppStrings.title.tr(),
                textInputType: TextInputType.text,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: searchTextField(
                controller: widget.viewModel.getPriceController,
                focusNode: priceFocusNode,
                nextFocus: categoryFocusNode,
                isObscured: false,
                validation: AppValidators.validateEmail,
                hint: AppStrings.price.tr(),
                textInputType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: searchTextField(
                controller: widget.viewModel.getCategoryController,
                focusNode: categoryFocusNode,
                nextFocus: condationFocusNode,
                isObscured: false,
                readOnly: true,
                surffixIcon: Icons.arrow_drop_down,

                validation: AppValidators.validateMartialStatus,
                hint: AppStrings.category.tr(),
                textInputType: TextInputType.text,
                onTap: () {
                  showRegisterDialog(
                    context,
                    onSelect: (v) {
                      widget.viewModel.getCategoryController.text = v;
                    },
                    items: categoryList, title: '',
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: searchTextField(
                controller: widget.viewModel.getConditionController,
                focusNode: condationFocusNode,
                nextFocus: descriptionFocusNode,
                isObscured: false,
                readOnly: true,
                surffixIcon: Icons.arrow_drop_down,

                validation: AppValidators.validateMartialStatus,
                hint: AppStrings.condition.tr(),
                textInputType: TextInputType.text,
                onTap: () {
                  showRegisterDialog(
                    context,
                    onSelect: (v) {
                      widget.viewModel.getConditionController.text = v;
                    },
                    items: CondationList, title: '',
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: searchTextField(
                controller: widget.viewModel.getPriceController,
                focusNode: descriptionFocusNode,

                nextFocus: locationFocusNode,
                isObscured: false,
                validation: AppValidators.validateEmail,
                hint: AppStrings.description.tr(),
                textInputType: TextInputType.text,
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: searchTextField(
                controller: widget.viewModel.getLocationController,
                focusNode: locationFocusNode,
                nextFocus: locationFocusNode,
                prefixIcon: Icons.location_on,
                isObscured: false,
                validation: AppValidators.validateEmail,
                hint: AppStrings.location.tr(),
                textInputType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p30),
              child: MainButton(
                text: AppStrings.publish.tr(),
                textStyle: AppTextStyles.sharePostBtnTextStyle(context),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.mainLayoutRoute,
                      ModalRoute.withName('/'),
                    );
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
