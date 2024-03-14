import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/onboarding_screen/view/widgets/onBoardingItems.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/routes_manager.dart';

import '../../common/widget/main_button.dart';
import '../../resources/color_manager.dart';
import '../../resources/text_styles.dart';
import 'widgets/onboarding_image.dart';
import 'widgets/onboarding_text.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = OnBoardingItems();
  final imageControler = PageController();
  final pageControler = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            itemCount: controller.items.length,
            controller: imageControler,
            itemBuilder: (context, index) {
              if (index != null) {
                pageControler.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                );
              }
              return OnboardingImage(
                onboardImage: controller.items[index].image,
              );
            },
          ),
          Positioned(
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
                child: PageView.builder(
                  itemCount: controller.items.length,
                  controller: pageControler,
                  itemBuilder: (context, index) {
                    imageControler.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                    );
                    return OnboardingText(
                      btnName: controller.items[index].title,
                      title: controller.items[index].btnName,
                      onPressed: () {
                        if (index == 0) {
                          pageControler.nextPage(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.selectionRoute,
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
