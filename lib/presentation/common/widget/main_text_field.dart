import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/text_styles.dart';

import '../../resources/values_manager.dart';

class MainTextField extends StatefulWidget {
  const MainTextField({
    super.key,
    this.label,
    required this.hint,
    this.isObscured = false,
    this.iconData,
    this.textInputType = TextInputType.text,
    this.backgroundColor,
    this.hintTextStyle,
    this.cursorColor = ColorManager.white,
  });

  final bool isObscured;
  final String? label;
  final String hint;
  final TextInputType textInputType;
  final IconData? iconData;
  final Color? backgroundColor;
  final TextStyle? hintTextStyle;
  final Color cursorColor;

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  late bool hidden = widget.isObscured;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null ? Padding(
          padding: const EdgeInsets.only(left: AppPadding.p10, top: AppPadding.p4),
          child: Text(
            widget.label!,
            style: AppTextStyles.authLabelTextStyle(context),
          ),
        ) : const SizedBox(),
        Container(
          margin: const EdgeInsets.only(top: AppMargin.m5),
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? ColorManager.darkGrey.withOpacity(.15),
            borderRadius: BorderRadius.circular(AppSize.s24),
          ),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            obscureText: hidden,
            keyboardType: widget.textInputType,
            obscuringCharacter: '*',
            cursorColor: widget.cursorColor,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(AppPadding.p12),
              hintText: widget.hint,
              suffixIcon: widget.isObscured
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          hidden = !hidden;
                        });
                      },
                      iconSize: AppSize.s24,
                      splashRadius: AppSize.s1,
                      isSelected: !hidden,
                      color: ColorManager.white,
                      selectedIcon: const Icon(CupertinoIcons.eye),
                      icon: const Icon(CupertinoIcons.eye_slash),
                    )
                  : null,
              hintStyle: widget.hintTextStyle ?? AppTextStyles.authHintTextStyle(context),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              filled: true,
              fillColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}
