import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/share_post_screen/home_services/home_services.dart';
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
  final HomeServices _homeServices =HomeServices();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode titleFocusNode = FocusNode();

  final FocusNode priceFocusNode = FocusNode();

  final FocusNode locationFocusNode = FocusNode();

  final FocusNode categoryFocusNode = FocusNode();

  final FocusNode condationFocusNode = FocusNode();

  final FocusNode descriptionFocusNode = FocusNode();
  List<String> _images = [];

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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: ImagePickerField(
                onImagePicked: (image) {
                  setState(() {
                    _images.add(image);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: SearchTextField(
                controller: widget.viewModel.getTitleController,
                focusNode: titleFocusNode,
                nextFocus: priceFocusNode,
                validation: AppValidators.validateText,
                isObscured: false,
                hint: AppStrings.title.tr(),
                textInputType: TextInputType.name,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: SearchTextField(
                controller: widget.viewModel.getPriceController,
                focusNode: priceFocusNode,
                nextFocus: categoryFocusNode,
                isObscured: false,
                validation: AppValidators.validatePrice,
                hint: AppStrings.price.tr(),
                textInputType: TextInputType.number,

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: SearchTextField(
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
                    items: categoryList,
                    title: '',
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: SearchTextField(
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
                    items: CondationList,
                    title: '',
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: SearchTextField(
                controller: widget.viewModel.getDescriptionController,
                focusNode: descriptionFocusNode,
                nextFocus: locationFocusNode,
                isObscured: false,
                validation: AppValidators.validateText,
                hint: AppStrings.description.tr(),
                textInputType: TextInputType.text,
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: SearchTextField(
                controller: widget.viewModel.getLocationController,
                focusNode: locationFocusNode,
                // readOnly: true,
                prefixIcon: Icons.location_on_rounded,
                surffixIconFunc: () {
                  Navigator.pushNamed(context, Routes.googleMapScreenShareRoute);

                },
                nextFocus: locationFocusNode,
                isObscured: false,
                validation: AppValidators.validateText,
                hint: AppStrings.location.tr(),
                textInputType: TextInputType.text,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p30),
              child: MainButton(
                text: AppStrings.publish.tr(),
                textStyle: AppTextStyles.sharePostBtnTextStyle(context),
                onTap: publish
              ),
            ),
          ],
        ),
      ),
    );
  }


  void publish() {
    if (_formKey.currentState!.validate()) {
      List<File> imageFiles = _images.map((path) => File(path)).toList();

      _homeServices.saveDataToFirestore(
        title: widget.viewModel.getTitleController.text,
        price: num.parse(widget.viewModel.getPriceController.text),
        category: widget.viewModel.getCategoryController.text,
        condition: widget.viewModel.getConditionController.text,
        description: widget.viewModel.getDescriptionController.text,
        location: widget.viewModel.getLocationController.text,
        images: imageFiles,
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.mainLayoutRoute,
        ModalRoute.withName('/'),
      );
    }
  }

}