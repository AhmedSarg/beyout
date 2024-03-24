import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../domain/models/enums.dart';
import '../../../../../common/data_intent/data_intent.dart';
import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../../resources/values_manager.dart';

class HomeImageWidget extends StatefulWidget {
  const HomeImageWidget({super.key});

  @override
  State<HomeImageWidget> createState() => _HomeImageWidgetState();
}

class _HomeImageWidgetState extends State<HomeImageWidget> {
  bool isFavourite = false;
  bool isFavMessage = false;

  UserRole? userRole = DataIntent.getUserRole();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
            child: Image.asset(
          ImageAssets.homeItem,
          fit: BoxFit.fitWidth,
          width: double.infinity,
        )),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p5, horizontal: AppPadding.p5),
          child: Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: ColorManager.black.withOpacity(.55),
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: Text('8000 ${AppStrings.priceHome.tr()}',
                        style: AppTextStyles.homeItemPriceTextStyle(context)),
                  )),
              Spacer(),
              InkWell(
                onTap: () {
                  var snackBar = SnackBar(
                    backgroundColor: ColorManager.offwhite,
                    closeIconColor: ColorManager.primary,
                    showCloseIcon: true,
                    duration: const Duration(seconds: AppDuration.s3),
                    content: Text(
                      isFavMessage
                          ? AppStrings.removeItem.tr()
                          : AppStrings.addItem.tr(),
                      style: AppTextStyles.nearHomeAddressTextStyle(context),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  setState(() {
                    isFavourite = !isFavourite;
                    isFavMessage = !isFavMessage;
                  });
                },
                child: userRole == UserRole.owner
                    ? Icon(
                        isFavourite
                            ? Icons.favorite
                            : Icons.favorite_outline_outlined,
                        color: isFavourite
                            ? ColorManager.primary
                            : ColorManager.white,
                        size: 30,
                      )
                    : IconButton(onPressed: () {}, icon: const Icon(Icons.menu_sharp,size: AppSize.s28,color: ColorManager.white,)),
              )
            ],
          ),
        )
      ],
    );
  }
}
