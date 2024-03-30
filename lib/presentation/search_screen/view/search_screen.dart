import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg package
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/routes_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';
import 'package:temp_house/presentation/search_screen/view/widgets/search_taps.dart';
import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';
import 'package:temp_house/presentation/common/widget/main_seach_field.dart';

import '../../resources/text_styles.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  bool _showClearIcon = false;
  List<String> searchedWords = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {
    setState(() {
      _showClearIcon = _searchController.text.isNotEmpty;
    });
  }

  void clearSearchField() {
    setState(() {
      _searchController.clear();
    });
  }

  Widget _buildTrailingIcon() {
    if (_showClearIcon) {
      return IconButton(
        icon: const Icon(Icons.clear),
        onPressed: clearSearchField,
      );
    } else {
      return IconButton(
        icon: SvgPicture.asset(
          SVGAssets.googleMaps,
          width: AppSize.s30,
          height: AppSize.s30,
        ),
        onPressed: () {
          Navigator.pushNamed(context, Routes.googleMapScreenRoute);
        },
      );
    }
  }

  Widget _buildSearchTaps() {
    if (_showClearIcon) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.lastText.tr(),
                  style: AppTextStyles.searchScreenTextStyle(context)),
              InkWell(
                  onTap: () {
                    setState(() {
                      searchedWords.clear();
                    });
                  },
                  child: Text(AppStrings.clearText.tr(),
                      style:
                      AppTextStyles.searchScreenClearTextStyle(context))),
            ],
          ),
          Container(
            height: AppSize.s50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: searchedWords.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppMargin.m8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s16),
                    border: Border.all(color: ColorManager.grey),
                  ),
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Text(
                    searchedWords[index],
                    style: AppTextStyles.searchHintTextStyle(context),
                  ),
                );
              },
            ),
          ),
        ],
      );

    } else {
      return  SearchTaps()
      ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: MainSearch(
          controller: _searchController,
          hintText: AppStrings.searchTextHint.tr(),
          leadingIcon: Icons.search,
          trailingIcon: _buildTrailingIcon(),
          onSubmit: (value) {
            setState(() {
              searchedWords.add(value);
            });
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Column(
          children: [

            _buildSearchTaps()

          ],
        ),
      ),
    );
  }
}
