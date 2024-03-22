import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';

class ShareTextField extends StatefulWidget {
  const ShareTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocus,
    this.label,
    required this.hint,
    this.isObscured = false,
    this.prefixIcon,
    this.textInputType = TextInputType.text,
    this.backgroundColor,
    this.hintTextStyle,
    this.labelTextStyle,
    this.cursorColor = ColorManager.white,
    this.readOnly = false,
    this.validation,
    this.onTap,
    this.surffixIcon,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocus;
  final bool isObscured;
  final String? label;
  final String hint;
  final TextInputType textInputType;
  final IconData? prefixIcon;
  final IconData? surffixIcon;
  final Color? backgroundColor;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final Color cursorColor;
  final bool readOnly;
  final String? Function(String?)? validation;
  final void Function()? onTap;
  @override
  State<ShareTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<ShareTextField> {
  late bool hidden = widget.isObscured;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          readOnly: widget.readOnly,
          style:
              widget.hintTextStyle ?? AppTextStyles.authHintTextStyle(context),
          obscureText: hidden,
          keyboardType: widget.textInputType,
          obscuringCharacter: '*',
          cursorColor: widget.cursorColor,
          onTap: widget.onTap,
          onEditingComplete: () {
            widget.focusNode.unfocus();
            if (widget.nextFocus != null) {
              FocusScope.of(context).requestFocus(widget.nextFocus);
            }
          },
          textInputAction: widget.nextFocus == null
              ? TextInputAction.done
              : TextInputAction.next,
          validator: (value) {
            if (widget.validation == null) {
              setState(() {
                errorText = null;
              });
            } else {
              setState(() {
                errorText = widget.validation!(value);
              });
            }
            return errorText;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(AppPadding.p12),
            hintText: widget.hint,
            prefixIcon: IconButton(onPressed: (){

            },icon: Icon(
              widget.prefixIcon,
              color: Colors.white,
              size: 30,
            ),),
            suffixIcon: Icon(
              widget.surffixIcon,
              color: Colors.white,
              size: 30,
            ),
            hintStyle: widget.hintTextStyle ??
                AppTextStyles.sharePostTextStyle(context),
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorManager.grey, style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorManager.grey, style: BorderStyle.solid)),
            errorStyle: const TextStyle(
              fontSize: AppSize.s0,
              color: ColorManager.transparent,
            ),
          ),
        ),
        errorText == null
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(
                  top: AppPadding.p8,
                  left: AppPadding.p8,
                ),
                child: Text(
                  errorText!,
                  style: AppTextStyles.authErrorTextStyle(context),
                ),
              ),
      ],
    );
  }
}