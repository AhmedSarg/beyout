import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:temp_house/presentation/common/widget/cached_image.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';
import '../../../common/widget/main_app_bar.dart';
import '../../../resources/text_styles.dart';

class HomeDetailsScreen extends StatefulWidget {
  final String id;
  final String title;
  final num price;
  final String location;
  final List<String> imageUrls;
  final String numnerofBeds;
  final String wifiServices;
  final String numnerofbathroom;
  final String description;

  const HomeDetailsScreen({
    Key? key,
    required this.title,
    required this.price,
    required this.location,
    required this.imageUrls,
    required this.numnerofBeds,
    required this.wifiServices,
    required this.numnerofbathroom,
    required this.id,
    required this.description, required date,
  }) : super(key: key);

  @override
  _HomeDetailsScreenState createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(widget.postedAt.toDate());

    return Scaffold(
      appBar: buildMainAppBar(
        context,
        Text(
          widget.title,
          style: AppTextStyles.notificationsScreenTitleTextStyle(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: AppSize.s200,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: widget.imageUrls.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                      child: CachedImage(
                        imageUrl: imageUrl,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: AppSize.s10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.imageUrls.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                "${_currentIndex + 1}/${widget.imageUrls.length}",
                style: AppTextStyles.smallTitleTextStyle(context),
              ),
              const SizedBox(width: AppSize.s16,)
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${AppStrings.price.tr()} : ',
                        style: AppTextStyles.homeDetailsDescriptionTextStyle(),
                      ),
                      TextSpan(
                        text: '${widget.price} ${AppStrings.priceHome.tr()}',
                        style: AppTextStyles.homeDetailsDescriptionContantTextStyle(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.s10),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${AppStrings.location.tr()} : ',
                        style: AppTextStyles.homeDetailsDescriptionTextStyle(),
                      ),
                      TextSpan(
                        text: widget.location,
                        style: AppTextStyles.homeDetailsDescriptionContantTextStyle(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.s10),
                // RichText(
                //   text: TextSpan(
                //     children: [
                //       TextSpan(
                //         text: '${AppStrings.homepostedAt.tr()} : ',
                //         style: AppTextStyles.homeDetailsDescriptionTextStyle(),
                //       ),
                //       TextSpan(
                //         text: formattedDate,
                //         style: AppTextStyles.homeDetailsDescriptionContantTextStyle(),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: AppSize.s10),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${AppStrings.description.tr()} : ',
                        style: AppTextStyles.homeDetailsDescriptionTextStyle(),
                      ),
                      TextSpan(
                        text: widget.description,
                        style: AppTextStyles.homeDetailsDescriptionContantTextStyle(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
