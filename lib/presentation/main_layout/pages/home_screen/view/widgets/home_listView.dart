import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';

import 'home_listView_iItem.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 350,

        enableInfiniteScroll: false,
        disableCenter: false,
        viewportFraction: .70,
        pageSnapping: false,
        scrollDirection: Axis.horizontal,
        initialPage: 0,
      ),
      items: [
        buildCarouselItem( color: ColorManager.offwhite, text: '',),
        buildCarouselItem( color: ColorManager.offwhite, text: '',),
        buildCarouselItem( color: ColorManager.offwhite, text: '',),

      ],
    );
  }

}
