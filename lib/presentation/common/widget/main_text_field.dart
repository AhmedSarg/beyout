import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/text_styles.dart';

import '../../resources/values_manager.dart';

class MainTextField extends StatefulWidget {
  const MainTextField({
    super.key,
    required this.text,
    this.isObscured = false,
    required this.hintText,
    this.iconData,
    this.textInputType = TextInputType.text,
  });

  final bool isObscured;
  final String text;
  final String hintText;
  final TextInputType textInputType;
  final IconData? iconData;

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
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 4),
          child: Text(
            widget.text,
            style: AppTextStyles.authLabelTextStyle(context),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: ColorManager.offwhite.withOpacity(.07),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                obscureText: hidden,
                keyboardType: widget.textInputType,
                obscuringCharacter: '*',
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: widget.hintText,
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
                  hintStyle: AppTextStyles.authHintTextStyle(context),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: Colors.transparent,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
