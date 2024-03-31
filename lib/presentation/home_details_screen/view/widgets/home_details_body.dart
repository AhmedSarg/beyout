import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
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
        const Divider(
          color: ColorManager.white,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product Name',
                style: AppTextStyles.homeDetailsNameTextStyle(),
              ),
              const SizedBox(height: AppSize.s10),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Description:',
                        style: AppTextStyles.homeDetailsDescriptionTextStyle()
                    ),
                    TextSpan(
                        text: '  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.:',
                        style: AppTextStyles.homeDetailsDescriptionContantTextStyle()

                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSize.s30),

              Row(
                children: [
                  Text(
                      'Rating: ',
                      style: AppTextStyles.homeDetailsDescriptionTextStyle()
                  ),
                  const SizedBox(width: AppSize.s10),
                  // Star rating system
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        Icons.star_rounded,
                        color: index < _rating.floor() ? Colors.orange.withOpacity(.7) : Colors.grey.withOpacity(.7),
                        size: AppSize.s35,
                      );
                    }),
                  ),
                ],
              ),

            ],
          ),
        ),
      ],
    );
  }
}
