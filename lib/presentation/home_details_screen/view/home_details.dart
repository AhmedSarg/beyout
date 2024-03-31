import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:temp_house/presentation/home_details_screen/view/widgets/home_details_body.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeDetails extends StatelessWidget {
  const HomeDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: const HomeDetailsBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.black,
        onPressed: () {
          // Add your onPressed logic here
        },
        child: GestureDetector(
          onTap: () {
            launch('tel:+201012951616');
          },
          child: Lottie.asset(
            LottieAssets.call,
          ),
        ),
      ),
    );
  }
}
