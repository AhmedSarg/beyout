import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';
import 'home_image.dart';

class BuildCarouselItem extends StatelessWidget {
  const BuildCarouselItem({
    Key? key,
    required this.color,
    required this.title,
    required this.price,
    required this.location,
    required this.imageUrl,
    required this.numnerofBeds,
    required this.wifiServices,
    required this.numnerofbathroom,
    required this.date,
    required this.id,
    required this.description,
  }) : super(key: key);

  final Color color;
  final String title;
  final String id;
  final num price;
  final String location;
  final String imageUrl;
  final String numnerofBeds;
  final String wifiServices;
  final String numnerofbathroom;
  final String date;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p10,
        vertical: AppPadding.p5,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppPadding.p16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.2,
              blurRadius: 0.2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p8,
            vertical: AppPadding.p12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
                child: HomeImageWidget(
                  price: NumberFormat.compactCurrency(
                          locale: 'en', symbol: '', decimalDigits: 2)
                      .format(price),
                  imageUrl: imageUrl,
                  date: date,
                ),
              ),
              const SizedBox(height: AppPadding.p5),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    '4.4',
                    style: AppTextStyles.homeItemRateTextStyle(context),
                  ),
                  Text(
                    '(480)',
                    style: AppTextStyles.homeItemSecondTextStyle(context),
                  ),
                ],
              ),
              Text(
                title,
                style: AppTextStyles.homeNameTextStyle(context),
              ),
              const SizedBox(height: AppPadding.p5),
              Row(
                children: [
                  SvgPicture.asset(
                    SVGAssets.pin,
                    color: ColorManager.primary,
                  ),
                  Expanded(
                    child: Text(
                      location,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.homeAddressTextStyle(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppPadding.p10),
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomeContent(
                      object: ' ${AppStrings.bedHome.tr()} ',
                      icon: SVGAssets.bed,
                      number: numnerofBeds,
                    ),
                    HomeContent(
                      object: ' ${AppStrings.wifiHome.tr()} ',
                      icon: wifiServices == AppStrings.wifiServicesYes.tr()
                          ? SVGAssets.wifi
                          : Icons.wifi_off_outlined,
                      number: '',
                    ),
                    HomeContent(
                      object: ' ${AppStrings.bathroomHome.tr()} ',
                      icon: SVGAssets.bathRoom,
                      number: numnerofbathroom,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({
    Key? key,
    required this.object,
    required this.icon,
    required this.number,
    this.color,
  }) : super(key: key);

  final String object;
  final dynamic icon;
  final String number;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (icon is String)
          SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(
                color ?? ColorManager.primary, BlendMode.dstIn),
          )
        else if (icon is IconData)
          Icon(
            icon,
            color: ColorManager.primary,
          ),
        Text(
          number,
          style: AppTextStyles.homeContentTextStyle(context),
        ),
        Text(
          overflow: TextOverflow.ellipsis,
          object,
          style: AppTextStyles.homeContentTextStyle(context),
        ),
      ],
    );
  }
}
