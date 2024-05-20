import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp_house/domain/models/domain.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../resources/values_manager.dart';

class HomeDetails extends StatelessWidget {
  const HomeDetails({
    super.key,
    required this.controller,
    required this.home,
  });

  final ScrollController controller;
  final HomeModel home;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppPadding.p20),
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        home.title,
                        style: AppTextStyles
                            .homesMapScreenHomeDetailsTitleTextStyle(context),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: ColorManager.lightGray,
                      ),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                Text(
                  'Home',
                  style:
                      AppTextStyles.homesMapScreenHomeDetailsSubtitleTextStyle(
                          context),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.anotherBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s10),
                      ),
                      fixedSize: const Size.fromHeight(AppSize.s50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          CupertinoIcons.car_detailed,
                          color: ColorManager.white,
                        ),
                        const SizedBox(width: AppSize.s10),
                        Text(
                          '7 Minutes',
                          style: AppTextStyles
                              .homesMapScreenHomeDetailsButtonTextStyle(
                                  context),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppSize.s10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s10),
                    ),
                    foregroundColor: ColorManager.darkGrey,
                    backgroundColor: const Color(0xffebebeb),
                    fixedSize: const Size(AppSize.s50, AppSize.s50),
                    padding: EdgeInsets.zero,
                    elevation: AppSize.s0,
                  ),
                  child: const Icon(
                    Icons.more_horiz,
                    size: AppSize.s30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s20),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p14,
                vertical: AppPadding.p30,
              ),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppSize.s15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: ColorManager.cobaltBlue,
                          child: SvgPicture.asset(
                            SVGAssets.bed,
                            color: ColorManager.white,
                          ),
                        ),
                        const SizedBox(width: AppSize.s10),
                        Expanded(
                          child: Text(
                            '${home.numberOfBeds} Beds',
                            style: AppTextStyles
                                .homesMapScreenHomeDetailsDetailTextStyle(
                                    context),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: ColorManager.cobaltBlue,
                          child: SvgPicture.asset(
                            SVGAssets.bathRoom,
                            color: ColorManager.white,
                          ),
                        ),
                        const SizedBox(width: AppSize.s10),
                        Expanded(
                          child: Text(
                            '${home.numberOfBathrooms} Bathrooms',
                            style: AppTextStyles
                                .homesMapScreenHomeDetailsDetailTextStyle(
                                    context),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSize.s20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Details',
                  style: AppTextStyles.homesMapScreenHomeDetailsHeadTextStyle(
                      context),
                ),
                const SizedBox(height: AppSize.s10),
                Container(
                  padding: const EdgeInsets.all(AppPadding.p14),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(AppSize.s15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Phone Number',
                        style: AppTextStyles
                            .homesMapScreenHomeDetailsDetailHeadTextStyle(
                                context),
                      ),
                      const SizedBox(height: AppSize.s5),
                      GestureDetector(
                        onTap: () {
                          launchUrlString('tel:+201003557878');
                        },
                        child: Text(
                          '+201003557878',
                          style: AppTextStyles
                              .homesMapScreenHomeDetailsDetailActionTextStyle(
                                  context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Divider(height: AppSize.s20),
                      Text(
                        'Address',
                        style: AppTextStyles
                            .homesMapScreenHomeDetailsDetailHeadTextStyle(
                                context),
                      ),
                      const SizedBox(height: AppSize.s5),
                      Text(
                        home.location,
                        style: AppTextStyles
                            .homesMapScreenHomeDetailsDetailTextStyle(context),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s20),
            Container(
              padding: const EdgeInsets.all(AppPadding.p14),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppSize.s15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: AppTextStyles
                        .homesMapScreenHomeDetailsDetailHeadTextStyle(context),
                  ),
                  const SizedBox(height: AppSize.s5),
                  Text(
                    home.description,
                    style: AppTextStyles
                        .homesMapScreenHomeDetailsDescriptionTextStyle(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSize.s20),
            Container(
              padding: const EdgeInsets.all(AppPadding.p14),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppSize.s15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Color(0xffebebeb),
                          child: Icon(
                            Icons.report,
                            color: ColorManager.anotherBlue,
                          ),
                        ),
                        const SizedBox(width: AppSize.s15),
                        Text(
                          'Report an Issue',
                          style: AppTextStyles
                              .homesMapScreenHomeDetailsDetailActionTextStyle(
                                  context),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: AppSize.s30),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Color(0xffebebeb),
                          child: Icon(
                            Icons.star_rounded,
                            color: ColorManager.anotherBlue,
                          ),
                        ),
                        const SizedBox(width: AppSize.s15),
                        Text(
                          'Add to Favorites',
                          style: AppTextStyles
                              .homesMapScreenHomeDetailsDetailActionTextStyle(
                                  context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSize.s20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.anotherBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s15),
                ),
              ),
              child: Text(
                'Close',
                style: AppTextStyles.homesMapScreenHomeDetailsButtonTextStyle(
                    context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
