import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/common/widget/main_button.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import 'home_details_images.dart';

class HomeDetailsBody extends StatefulWidget {
  const HomeDetailsBody({Key? key}) : super(key: key);

  @override
  State<HomeDetailsBody> createState() => _HomeDetailsBodyState();
}

class _HomeDetailsBodyState extends State<HomeDetailsBody> {
  double _rating = 4;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.40,
          child: const HomeDetailsImages(),
        ),
        Divider(
          color: ColorManager.white,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product Name',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppSize.s10),
              Text(
                'Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: AppSize.s30),

              Row(
                children: [
                  Text(
                    'Rating: ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: AppSize.s10),
                  // Star rating system
                  Row(
                    children: List.generate(5, (index) {
                      return IconButton(
                        onPressed: () {
                          setState(() {
                            _rating = index + 1;
                          });
                        },
                        icon: Icon(
                          index < _rating.floor()
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(height: AppSize.s20),

            Center(
              child: MainButton(backgroundColor: ColorManager.primary,text: 'Add To Card', textStyle: AppTextStyles.feedBackBtnTextStyle(context), onTap: () {

              },),
            )
            ],
          ),
        ),
      ],
    );
  }
}
