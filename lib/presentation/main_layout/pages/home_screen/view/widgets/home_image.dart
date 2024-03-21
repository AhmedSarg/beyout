import 'package:flutter/material.dart';

import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../../resources/values_manager.dart';

class HomeImageWidget extends StatelessWidget {
  const HomeImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(child: Image.asset(ImageAssets.homeItem,fit: BoxFit.cover,)),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p5, horizontal:AppPadding.p5 ),
          child: Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: ColorManager.black.withOpacity(.55),
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: Text('8000 EGP/Month',
                        style: AppTextStyles.homeItemPriceTextStyle(context)),
                  )),
              Spacer(),
              Icon(
                Icons.favorite_outline_outlined,
                color: ColorManager.white,
                size: 30,
              )
            ],
          ),
        )
      ],
    );
  }
}
