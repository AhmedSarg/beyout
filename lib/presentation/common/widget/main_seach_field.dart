import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../resources/text_styles.dart';

class MainSearch extends StatelessWidget {
  const MainSearch({super.key, required this.hintText, required this.leadingIcon, required this.trailingIcon});
final String hintText;
  final IconData leadingIcon;
  final IconData trailingIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppMargin.m36),
      decoration: BoxDecoration(
        color: ColorManager.offwhite.withOpacity(.12),
            borderRadius: BorderRadius.circular(16)
      ),
      child:  TextField(

        cursorColor: ColorManager.white,

        style: AppTextStyles.searchTextStyle(context),
        decoration:  InputDecoration(
          prefixIcon: Icon(leadingIcon),
          prefixIconColor: ColorManager.offwhite.withOpacity(.86),
          suffixIcon: Icon(trailingIcon),
          suffixIconColor: ColorManager.offwhite.withOpacity(.86),
          hintText: hintText,
          hintStyle: AppTextStyles.searchHintTextStyle(context),
          border: InputBorder.none,
          fillColor: Colors.transparent,
          filled: false,
        ),
      ),
    );
  }
}
