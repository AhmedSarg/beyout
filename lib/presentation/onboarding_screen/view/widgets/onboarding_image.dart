import 'package:flutter/material.dart';

import '../../../resources/assets_manager.dart';

class OnboardingImage extends StatelessWidget {
  const OnboardingImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          ImageAssets.boardImage1,
          width: double.infinity,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height*.7,
        ),

      ],
    );
  }
}
