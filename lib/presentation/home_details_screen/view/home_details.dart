import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:temp_house/presentation/home_details_screen/view/widgets/home_details_body.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';

class HomeDetails extends StatelessWidget {
  const HomeDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorManager.white,
      body: HomeDetailsBody(),
    );
  }
}
