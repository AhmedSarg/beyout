import 'package:flutter/material.dart';
import 'package:temp_house/presentation/common/widget/main_button.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/text_styles.dart';

class OnboardingText extends StatelessWidget {
  const OnboardingText({Key? key, required this.btnName, required this.title})
      : super(key: key);

  final String btnName;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        height: MediaQuery.of(context).size.height * .35,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
                onTap: () {},
                text: btnName,
                textStyle: const TextStyle(),
              ),
              const Spacer(),

            ],
          ),
        ),
      ),
    );
  }
}
