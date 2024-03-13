import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';

class CommonBtnTransperant extends StatelessWidget {
  CommonBtnTransperant({super.key, required this.title, this.onTap});
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: ColorManager.btn.withOpacity(.19),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Center(
            child: TextButton(
              onPressed:  onTap,
              child: Text(
                title,
                style: AppTextStyles.authBtnTextStyle(context),
              ),
            )),
      ),
    );
  }
}
