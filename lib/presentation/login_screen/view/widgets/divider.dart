import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';

class Line extends StatelessWidget {
  const Line({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.4,
      color: ColorManager.lightGrey,
    );
  }
}
