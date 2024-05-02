import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:temp_house/app/extensions.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../../../common/widget/cached_image.dart';
import '../../../../../common/widget/main-divider.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/routes_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';

class NearByHomeItem extends StatefulWidget {
  const NearByHomeItem({
    super.key,
    required this.color,
    required this.title,
    required this.id,
    required this.price,
    required this.location,
    required this.imageUrl,
    required this.numnerofBeds,
    required this.wifiServices,
    required this.numnerofbathroom,
    required this.date,
    required this.description, required this.coardinaties,
  });
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
  final GeoPoint coardinaties;

  @override
  State<NearByHomeItem> createState() => _NearByHomeItemState();
}

class _NearByHomeItemState extends State<NearByHomeItem> {
  bool isFav = false;
  bool isFavMessage = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppMargin.m10),
      color: ColorManager.transparent,
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s12),
              child: CachedImage(
                imageUrl: widget.imageUrl ?? "",
                width: MediaQuery.of(context).size.width * 0.45,
                height: AppSize.s120,
              ),
            ),
            const SizedBox(width: AppSize.s10),
            SizedBox(
              width: context.width() - AppSize.s180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          widget.title,
                          style: AppTextStyles.nearHomeNameTextStyle(context),
                        ),
                      ),
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
                                style: AppTextStyles.nearHomeAddressTextStyle(
                                    context),
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
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
                          widget.location,
                          maxLines: 1,
                          style:
                              AppTextStyles.nearHomeAddressTextStyle(context),
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
                        '${AppStrings.coin.tr()} ${widget.price}${widget.date}',
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
                          style:
                              AppTextStyles.homeItemSecondTextStyle(context)),
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
