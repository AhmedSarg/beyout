import 'package:flutter/material.dart';
import 'package:temp_house/app/extensions.dart';

import '../../../common/widget/main_button.dart';
import '../../../common/widget/main_text_field.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/values_manager.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    double height = context.height() / 2;
    return Container(
      height: height,
      width: AppSize.infinity,
      color: ColorManager.white,
      child: Column(
        children: [
          const Spacer(flex: 4),
          const MainTextField(text: 'text', isObscured: false, hintText: 'hintText'),
          const Divider(),
          MainButton(
            text: 'title',
            onTap: () {},
            textStyle: const TextStyle(),
          ),
          const Spacer(flex: 4),
        ],
      ),
    );
  }
}
