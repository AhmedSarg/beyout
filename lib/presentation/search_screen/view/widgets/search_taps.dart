import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/constants_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../share_post_screen/view/widgets/share_text_field.dart';
import 'modal_bottom_sheet_botton.dart';

class SearchTaps extends StatefulWidget {
  SearchTaps({super.key});

  @override
  State<SearchTaps> createState() => _SearchTapsState();
}

class _SearchTapsState extends State<SearchTaps> {
  List<String> items = [
    AppStrings.tapBarSearchAll.tr(),
    AppStrings.tapBarSearchLatest.tr(),
    AppStrings.tapBarSearchPopular.tr(),
    AppStrings.tapBarSearchPrice.tr(),
    AppStrings.tapBarSearchCheapest.tr(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppMargin.m5),
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: AppSize.s60,
            width: double.infinity,
            child: ListView.builder(
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = index;
                          if (items[index] == AppStrings.tapBarSearchPrice.tr()) {
                            _showBottomSheet(context, items[index]);
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration:
                            const Duration(milliseconds: AppDuration.m300),
                        margin: const EdgeInsets.all(AppMargin.m5),
                        height: AppSize.s45,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s8),
                            border: Border.all(
                              color: currentIndex == index
                                  ? ColorManager.offwhite.withOpacity(.5)
                                  : ColorManager.tertiary, // Border color
                              width: 1, // Border width
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.2), // Shadow color
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            color: currentIndex == index
                                ? ColorManager.offwhite.withOpacity(.5)
                                : ColorManager.additional.withOpacity(.6),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p12),
                              child: Text(
                                items[index],
                                style: currentIndex == index
                                    ? AppTextStyles.selectedSearchTabTextStyle(
                                        context)
                                    : AppTextStyles
                                        .unSelectedsearchTabTextStyle(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: currentIndex == index,
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.tertiary.withOpacity(.6)),
                      ),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  // Function to show modal bottom sheet
  void _showBottomSheet(BuildContext context, String item) {
    double _minValue = AppConstants.intialMinPrice ;
    double _maxValue = AppConstants.intialMaxPrice;
    double _step = AppConstants.stepPrice; // St


    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            void _decreaseMinValue() {
              setState(() {
                _minValue = (_minValue - _step).clamp(0.0, _maxValue - _step);
              });
            }

            void _increaseMaxValue() {
              setState(() {
                _maxValue = (_maxValue + _step).clamp(_minValue + _step, AppConstants.maxRange);
              });
            }

            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p16, vertical: AppPadding.p30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container(
                      height: AppSize.s5,
                      width: AppSize.s35,
                      decoration: BoxDecoration(
                          color: ColorManager.grey,
                          borderRadius: BorderRadius.circular(AppPadding.p16)),
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s20,
                  ),
                  Text(
                    AppStrings.priceRange.tr(),
                    style: AppTextStyles.modalBottomSheetPriceTitleTextStyle(
                        context),
                  ),
                  Divider(
                    color: ColorManager.grey,
                  ),
                  SizedBox(height: AppSize.s20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${_minValue.toInt()} ${AppStrings.coin.tr()}',
                        style: AppTextStyles.modalBottomSheetPriceTextStyle(
                            context),
                      ),
                      Text('${_maxValue.toInt()}${AppStrings.coin.tr()}',
                          style: AppTextStyles.modalBottomSheetPriceTextStyle(
                              context)),
                    ],
                  ),

                  SizedBox(height: AppSize.s30),
                  RangeSlider(
                    activeColor: ColorManager.cobaltRed,
                    inactiveColor: ColorManager.cobaltPink,
                    values: RangeValues(_minValue, _maxValue),
                    min: AppConstants.minRange,
                    max: AppConstants.maxRange,
                    onChanged: (RangeValues values) {
                      setState(() {
                        _minValue = values.start;
                        _maxValue = values.end;
                      });
                    },
                  ),
                  SizedBox(height: AppSize.s30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      modalBottomSheetBotton(
                        btName: AppStrings.minNum.tr(),
                        backGroundColor: Colors.transparent,
                        btNameColor: ColorManager.black,
                        onPressed: _decreaseMinValue,
                      ),
                      Container(
                        height: AppSize.s4,
                        width: AppSize.s35,
                        decoration: BoxDecoration(
                            color: ColorManager.grey,
                            borderRadius:
                                BorderRadius.circular(AppPadding.p16)),
                      ),
                      modalBottomSheetBotton(
                        btName: AppStrings.maxNum.tr(),
                        backGroundColor: Colors.transparent,
                        btNameColor: ColorManager.black,
                        onPressed: _increaseMaxValue,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s15,
                  ),

                  const Divider(
                    color: ColorManager.grey,
                  ),
                  const SizedBox(
                    height: AppSize.s15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      modalBottomSheetBotton(
                        btName: AppStrings.clear.tr(),
                        backGroundColor: Colors.transparent,
                        btNameColor: ColorManager.black,
                        onPressed: () {
                          setState(() {
                            _minValue = AppConstants.intialMinPrice;
                            _maxValue = AppConstants.intialMaxPrice;
                          });
                        },
                      ),

                      modalBottomSheetBotton(
                        btName: AppStrings.confirm.tr(),
                        backGroundColor: ColorManager.cobaltBlue,
                        btNameColor: ColorManager.white,
                        onPressed: () {
                        Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
