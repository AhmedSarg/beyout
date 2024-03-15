import 'package:flutter/material.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/routes_manager.dart';
import 'onboarding_image.dart';
import 'onboarding_items.dart';
import 'onboarding_text.dart';

class OnBoardingBody extends StatelessWidget {
  OnBoardingBody({super.key});

  final List<OnBoardingItem> onboardingItems = [
    OnBoardingItem(
        image: ImageAssets.boardImage1,
        title: 'Start',
        btnName: 'Booking Home Anywhere Is\nEasier'),
    OnBoardingItem(
        image: ImageAssets.boardImage2,
        title: 'GET STARTED',
        btnName: 'Thousands Of Houses To Be\nFound'),
  ];

  final PageController imageController = PageController();
  final PageController boxController = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          itemCount: onboardingItems.length,
          controller: imageController,
          itemBuilder: (context, index) {
            return OnboardingImage(
              onboardImage: onboardingItems[index].image,
            );
          },
          onPageChanged: (index) {
            boxController.animateToPage(
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
                itemCount: onboardingItems.length,
                controller: boxController,
                itemBuilder: (context, index) {
                  return OnboardingText(
                    btnName: onboardingItems[index].title,
                    title: onboardingItems[index].btnName,
                    onPressed: () {
                      if (index == 0) {
                        boxController.nextPage(
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
                onPageChanged: (index) {
                  imageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
