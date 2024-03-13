import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/values_manager.dart';

class Line extends StatelessWidget {
  const Line({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s1_4,
      color: ColorManager.lightGrey,
    );
  }
}
