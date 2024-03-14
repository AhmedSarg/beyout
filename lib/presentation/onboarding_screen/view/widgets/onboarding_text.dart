import 'package:flutter/material.dart';
import 'package:temp_house/presentation/common/widget/main_button.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/text_styles.dart';

class OnboardingText extends StatelessWidget {
  const OnboardingText({
    Key? key,
    required this.btnName,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final String btnName;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              title,
              style: AppTextStyles.splashScreenSubTitleTextStyle(context),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        MainButton(
          onTap: () {
            onPressed();
          },
          text: btnName,
          textStyle: const TextStyle(),
        ),
        const Spacer(),
      ],
    );
  }
}
