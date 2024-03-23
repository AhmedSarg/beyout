import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../resources/text_styles.dart';

class SearchTaps extends StatefulWidget {
  SearchTaps({super.key});

  @override
  State<SearchTaps> createState() => _SearchTapsState();
}

class _SearchTapsState extends State<SearchTaps> {
  List<String> items = [
    'All',
    'Latest',
    'Price',
    'Most popular',
    'Cheapest',
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppMargin.m5),
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
                          if(items[index] == 'Price') {
                            _showBottomSheet(context, items[index]);
                          }



                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: AppDuration.m300),
                        margin: const EdgeInsets.all(AppMargin.m5),
                        height: AppSize.s45,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s8),
                            border: Border.all(
                              color:currentIndex == index
                                  ? ColorManager.offwhite.withOpacity(.5)
                                  : ColorManager.tertiary, // Border color
                              width: 1, // Border width
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2), // Shadow color
                                spreadRadius: 2,  // Spread radius
                                blurRadius: 4,    // Blur radius
                                offset: Offset(0, 2), // Offset from the container
                              ),
                            ],
                            color: currentIndex == index
                                ? ColorManager.offwhite.withOpacity(.5)
                                : ColorManager.additional.withOpacity(.6),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric( horizontal: AppPadding.p12),
                              child: Text(items[index],style:currentIndex == index? AppTextStyles.selectedSearchTabTextStyle(context):AppTextStyles.unSelectedsearchTabTextStyle(context),),
                            ),
                          ),
                        ),
                      ),


                    ),
                    Visibility(
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: ColorManager.tertiary.withOpacity(.6)),
                      ),
                      visible: currentIndex == index,
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
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Center(
            child: Text('This is the bottom sheet for $item'),
          ),
        );
      },
    );
  }
}
