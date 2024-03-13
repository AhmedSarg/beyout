import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';

class CommonTextField extends StatefulWidget {
  CommonTextField({Key? key, required this.text, required this.isObscured, required this.hintText,  this.iconData}) : super(key: key);

  final bool isObscured;
  final String text;
  final String hintText;
  final IconData? iconData;

  @override
  _CommonTextFieldState createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 4),
          child: Text(
            widget.text,
            style: AppTextStyles.authTextStyle(context),
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
                style: TextStyle(color: Colors.white),
                obscureText: widget.isObscured,
                obscuringCharacter: '*',
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  suffixIcon: Icon(widget.iconData,color: ColorManager.white,) ,
                  hintStyle: AppTextStyles.authHintTextTextStyle(context),
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
