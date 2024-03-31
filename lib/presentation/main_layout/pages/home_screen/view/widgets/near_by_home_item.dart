import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../../../common/widget/main-divider.dart';
import '../../../../../resources/color_manager.dart';
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              ImageAssets.homeItem,
              width: 150,
              fit: BoxFit.cover,
            ),
SizedBox(width: AppSize.s5,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Green Palace',
                      style: AppTextStyles.nearHomeNameTextStyle(context),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
               IconButton(onPressed: () {
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
               }, icon:      Icon(
                 isFav ? Icons.favorite : Icons.favorite_outline,
                 color: ColorManager.primary,
                 size: AppSize.s28,
               ))
                  ],
                ),
                Row(children: [
                  SvgPicture.asset(
                    SVGAssets.pin,
                    color: ColorManager.primary,
                  ),
                  Container(
                    width: 120,
                    child: Text(
                      'A Silwa mawatha1111',
                      style: AppTextStyles.nearHomeAddressTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ]),
                Row(children: [
                  Container(
                    width: 120,
                    child: Text(
                      'Rs 4000/ Day',
                      style: AppTextStyles.nearHomeAddressTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ]),
                Row(
                  children: [
                    SizedBox(
                      width: 70,
                    ),
                    Icon(
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
              ],
            ),
          ],
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        const MainDivider()
      ],
    );
  }
}
