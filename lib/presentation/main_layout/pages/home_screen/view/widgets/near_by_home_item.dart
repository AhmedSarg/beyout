import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp_house/app/extensions.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../../../common/widget/main-divider.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/routes_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';

class NearByHomeItem extends StatefulWidget {
  const NearByHomeItem({super.key});

  @override
  State<NearByHomeItem> createState() => _NearByHomeItemState();
}

class _NearByHomeItemState extends State<NearByHomeItem> {
  bool isFav = false;
  bool isFavMessage = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.homeDetailsRoute);
      },
      child: Container(
        margin: const EdgeInsets.all(AppMargin.m10),
        color: ColorManager.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImageAssets.homeItem,
              width: AppSize.s150,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: AppSize.s10),
            SizedBox(
              width: context.width() - AppSize.s180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Green Palace',
                        style: AppTextStyles.nearHomeNameTextStyle(context),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            var snackBar = SnackBar(
                              backgroundColor: ColorManager.offwhite,
                              closeIconColor: ColorManager.primary,
                              showCloseIcon: true,
                              duration: const Duration(seconds: AppDuration.s3),
                              content: Text(
                                isFavMessage
                                    ? AppStrings.removeItem.tr()
                                    : AppStrings.addItem.tr(),
                                style:
                                    AppTextStyles.nearHomeAddressTextStyle(context),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            setState(() {
                              isFav = !isFav;
                              isFavMessage = !isFavMessage;
                            });
                          },
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_outline,
                            color: ColorManager.primary,
                            size: AppSize.s28,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        SVGAssets.pin,
                        color: ColorManager.primary,
                        width: AppSize.s20,
                      ),
                      Expanded(
                        child: Text(
                          'A Silwa mawatha11',
                          style: AppTextStyles.nearHomeAddressTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s5),
                  Row(
                    children: [
                      const SizedBox(width: AppSize.s10),
                      Text(
                        'EGP 400/Day',
                        style: AppTextStyles.nearHomeAddressTextStyle(context),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: AppSize.s20,
                      ),
                      Text('4.4',
                          style: AppTextStyles.homeItemRateTextStyle(context)),
                      const SizedBox(width: AppSize.s5),
                      Text('(480)',
                          style: AppTextStyles.homeItemSecondTextStyle(context)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
