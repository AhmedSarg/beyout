import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp_house/presentation/main_layout/pages/home_screen/view/widgets/home_image.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/routes_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';

class buildCarouselItem extends StatelessWidget {
  const buildCarouselItem({super.key, required this.color, required this.text, required this.title, required this.price, required this.location, required this.imageUrl});
  final Color color;
  final num price;
  final String text;
  final String title;
  final String location;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.homeDetailsRoute);
      },
      child: Padding(
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
                SizedBox(
                    height: MediaQuery.of(context).size.height*.20,
                    child: HomeImageWidget(price: price.toString(), imageUrl: imageUrl,)),
                const SizedBox(
                  height: AppPadding.p5,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text('4.4',
                        style: AppTextStyles.homeItemRateTextStyle(context)),
                    Text('(480)',
                        style: AppTextStyles.homeItemSecondTextStyle(context)),
                  ],
                ),
                Row(
                  children: [
                    Text(title,
                        style: AppTextStyles.homeNameTextStyle(context)),
                  ],
                ),
                SizedBox(
                  height: AppPadding.p5,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      SVGAssets.pin,
                      color: ColorManager.primary,
                    ),
                    Expanded(
                      child: Text(location,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.homeAddressTextStyle(context)),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppPadding.p10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomeContent(
                      object: '2 ${AppStrings.bedHome.tr()}',
                      icon: SVGAssets.bed,
                    ),
                    HomeContent(object: '${AppStrings.wifiHome.tr()}', icon: SVGAssets.wifi),
                    HomeContent(
                      object: '1 ${AppStrings.bathroomHome.tr()}',
                      icon: SVGAssets.bathRoom,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key, required this.object, required this.icon})
      : super(key: key);

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
        SizedBox(
          width: AppPadding.p4,
        ),
        Text(
          object,
          style: AppTextStyles.homeContentTextStyle(context),
        ),
      ],
    );
  }
}
