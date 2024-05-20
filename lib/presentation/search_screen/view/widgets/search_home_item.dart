import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp_house/app/extensions.dart';
import 'package:temp_house/domain/models/domain.dart';
import 'package:temp_house/presentation/base/base_states.dart';
import 'package:temp_house/presentation/main_layout/viewmodel/main_layout_viewmodel.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/font_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../common/widget/cached_image.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';

class SearchHomeItem extends StatelessWidget {
  const SearchHomeItem({
    super.key,
    required this.home,
  });

  final HomeModel home;

  @override
  Widget build(BuildContext context) {
    final double displayedRating = (home.rate / home.numberOfRates).clamp(0, 5);
    return BlocBuilder<MainLayoutViewModel, BaseStates>(
      builder: (context, state) {
        MainLayoutViewModel viewModel = MainLayoutViewModel.get(context);
        return Container(
          margin: const EdgeInsets.all(AppMargin.m10),
          color: ColorManager.primary,
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    child: CachedImage(
                      imageUrl: home.imageUrl,
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: AppSize.s120,
                    ),
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
                              home.title,
                              style: AppTextStyles.homegenertalTextStyle(
                                  context, ColorManager.offwhite, FontSize.f18),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (viewModel.isHomeFavorite(home.homeId)) {
                                viewModel.removeFromFavorites(home.homeId);
                              } else {
                                viewModel.addToFavorites(home.homeId);
                              }
                            },
                            icon: Icon(
                              viewModel.isHomeFavorite(home.homeId)
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: ColorManager.grey,
                              size: AppSize.s28,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            SVGAssets.pin,
                            color: ColorManager.grey,
                            width: AppSize.s20,
                          ),
                          Expanded(
                            child: Text(
                              home.location,
                              maxLines: 1,
                              style: AppTextStyles.homegenertalTextStyle(
                                  context, ColorManager.offwhite, FontSize.f14),
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
                            '${AppStrings.coin.tr()} ${home.price}${home.rentPeriod}',
                            style: AppTextStyles.homegenertalTextStyle(
                                context, ColorManager.offwhite, FontSize.f14),
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
                          Text(
                            displayedRating.toStringAsFixed(1),
                            style: AppTextStyles.homegenertalTextStyle(
                                context, ColorManager.offwhite, FontSize.f12),
                          ),
                          const SizedBox(width: AppSize.s5),
                          Text(
                            '(${home.numberOfRates})',
                            style: AppTextStyles.homegenertalTextStyle(
                                context,
                                ColorManager.tertiary.withOpacity(.7),
                                FontSize.f12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
