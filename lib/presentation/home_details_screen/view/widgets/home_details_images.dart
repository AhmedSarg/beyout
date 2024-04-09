import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../main_layout/pages/home_screen/view/widgets/home_image.dart';

class HomeDetailsImages extends StatefulWidget {
  const HomeDetailsImages({super.key});

  @override
  State<HomeDetailsImages> createState() => _HomeDetailsBodyState();
}

class _HomeDetailsBodyState extends State<HomeDetailsImages> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: Alignment.bottomRight,
      children: [
        // Slider Section
        Center(
          child: CarouselSlider(
            items: [
              HomeImageWidget(price: '', imageUrl: '', Date: '',),
              HomeImageWidget(price: '', imageUrl: '', Date: '',),
              HomeImageWidget(price: '', imageUrl: '', Date: '',),
              HomeImageWidget(price: '', imageUrl: '', Date: '',),

            ],
            options: CarouselOptions(

              aspectRatio: 16 / 9, // Adjust aspect ratio as needed
              viewportFraction: 1,

              autoPlay: false,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ),
                    SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (index) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              width: _currentIndex == index ? 12.0 : 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index
                    ? Colors.grey
                    : Colors.grey.withOpacity(0.5),
              ),
            );
          }),
        ),
        // Image Counter
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${_currentIndex + 1}/4', // Change the value dynamically based on the current image index
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ],
    );
  }
}
