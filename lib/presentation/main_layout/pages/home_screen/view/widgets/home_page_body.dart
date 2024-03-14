import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';

import '../../../../../resources/text_styles.dart';
import 'homePageAppBar.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return   SingleChildScrollView(
      child: Column(
        children: [
          HomePageAppBar(),
          SizedBox(height: 250,),
          Container(
            height: 500,
            decoration: BoxDecoration(
              color: ColorManager.offwhite,
              borderRadius: BorderRadius.only(topRight: Radius.circular(42),topLeft: Radius.circular(42))
            ),
          )
      
      
        ],
      ),
    );
  }
}
