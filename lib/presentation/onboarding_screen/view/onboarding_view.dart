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
  final imageController = PageController();
  final pageController = PageController();
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPageIndex = pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            itemCount: controller.items.length,
            controller: imageController,
            itemBuilder: (context, index) {
              return OnboardingImage(
                onboardImage: controller.items[index].image,
              );
            },
            onPageChanged: (index) {
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
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
                  controller: pageController,
                  itemBuilder: (context, index) {
                    return OnboardingText(
                      btnName: controller.items[index].title,
                      title: controller.items[index].btnName,
                      onPressed: () {
                        if (currentPageIndex == 0) {
                          pageController.nextPage(
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
