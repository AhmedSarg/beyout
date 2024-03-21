import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp_house/presentation/main_layout/pages/home_screen/view/widgets/home_image.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../../../resources/text_styles.dart';

class buildCarouselItem extends StatelessWidget {
  const buildCarouselItem({super.key, required this.color, required this.text});
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p10,
          vertical: AppPadding.p5), // Adjust padding between items
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppPadding.p16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: .2,
              blurRadius: .2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p8, vertical: AppPadding.p12),
          child: Column(
            children: [
              HomeImageWidget(),
              SizedBox(height: AppPadding.p5,),

              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 3,),
                  Text('4.4',
                      style: AppTextStyles.homeItemRateTextStyle(context)),
                  Text('(480)',
                      style: AppTextStyles.homeItemSecondTextStyle(context)),
                ],
              ),

              Row(
                children: [

                  Text('Lerissa Galian Home',
                      style: AppTextStyles.homeNameTextStyle(context)),

                ],
              ),
              SizedBox(height: AppPadding.p5,),

              Row(
                children: [
                  SvgPicture.asset(SVGAssets.pin,color: ColorManager.primary,),
                  Expanded(
                    child: Text('11/ B, Perera lane, Colombo 06',
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.homeAddressTextStyle(context)),
                  ),

                ],
              ),
SizedBox(height: AppPadding.p10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HomeContent(object: 'bed', icon: SVGAssets.bed,),
                  HomeContent(object: 'wifi', icon: SVGAssets.wifi),
                  HomeContent(object: 'bathroom', icon: SVGAssets.bathRoom,),


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class HomeContent extends StatelessWidget {
  const HomeContent({Key? key, required this.object, required this.icon}) : super(key: key);

  final String object;
  final String icon;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(
          icon,
          color: ColorManager.primary,
        ),
        SizedBox(width: AppPadding.p4,),
        Text(
          object,
          style: AppTextStyles.homeContentTextStyle(context),
        ),
      ],
    );
  }
}