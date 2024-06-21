import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:temp_house/domain/models/enums.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';
import 'package:temp_house/presentation/main_layout/pages/favourite_screen/view/favourite_page.dart';
import 'package:temp_house/presentation/offers_screen/view/offers_view.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';

import '../../resources/text_styles.dart';
import '../pages/home_screen/view/home_page.dart';
import '../pages/profile_screen/view/profile_page.dart';

class MainLayoutBody extends StatefulWidget {
  const MainLayoutBody({super.key});

  @override
  State<MainLayoutBody> createState() => _MainLayoutBodyState();
}

class _MainLayoutBodyState extends State<MainLayoutBody> {
  int selectedTabIndex = 0;

  List<Widget> ownerTabs = [
    const HomePage(),
    const FavouriteScreen(),
    const OffersScreen(),
    const ProfileScreen()
  ];

  List<Widget> tenantTabs = [
    const HomePage(),
    const FavouriteScreen(),
    const ProfileScreen()
  ];

  List<BottomNavigationBarItem> ownerNavBarItems = [
    BottomNavigationBarItem(
      backgroundColor: ColorManager.primary,
      icon: const Icon(Icons.home_outlined),
      activeIcon: const Icon(Icons.home_rounded),
      label: AppStrings.homeNavBarHome.tr(),
    ),
    BottomNavigationBarItem(
      backgroundColor: ColorManager.primary,
      icon: const Icon(Icons.favorite_border),
      activeIcon: const Icon(Icons.favorite),
      label: AppStrings.homeNavBarFavourite.tr(),
    ),
    BottomNavigationBarItem(
      backgroundColor: ColorManager.primary,
      icon: const Icon(Icons.notifications_outlined),
      activeIcon: const Icon(Icons.notifications),
      label: AppStrings.homeNavBarNotifications.tr(),
    ),
    BottomNavigationBarItem(
      backgroundColor: ColorManager.primary,
      icon: const Icon(Icons.person_outline_rounded),
      activeIcon: const Icon(Icons.person_rounded),
      label: AppStrings.homeNavBarProfile.tr(),
    ),
  ];

  List<BottomNavigationBarItem> tenantNavBarItems = [
    BottomNavigationBarItem(
      backgroundColor: ColorManager.primary,
      icon: const Icon(Icons.home_outlined),
      activeIcon: const Icon(Icons.home_rounded),
      label: AppStrings.homeNavBarHome.tr(),
    ),
    BottomNavigationBarItem(
      backgroundColor: ColorManager.primary,
      icon: const Icon(Icons.favorite_border),
      activeIcon: const Icon(Icons.favorite),
      label: AppStrings.homeNavBarFavourite.tr(),
    ),
    BottomNavigationBarItem(
      backgroundColor: ColorManager.primary,
      icon: const Icon(Icons.person_outline_rounded),
      activeIcon: const Icon(Icons.person_rounded),
      label: AppStrings.homeNavBarProfile.tr(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        onPopInvoked: (_) {
          if (selectedTabIndex == 0) {
            SystemNavigator.pop();
          } else {
            setState(() {
              selectedTabIndex = 0;
            });
          }
        },
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: false,
              enableFeedback: true,
              onTap: (index) {
                setState(() {
                  selectedTabIndex = index;
                });
              },
              selectedLabelStyle: AppTextStyles.mainNavBarLabel(context),
              currentIndex: selectedTabIndex,
              type: BottomNavigationBarType.shifting,
              items: DataIntent.getUserRole() == UserRole.owner
                  ? ownerNavBarItems
                  : tenantNavBarItems),
          body: (DataIntent.getUserRole() == UserRole.owner
              ? ownerTabs
              : tenantTabs)[selectedTabIndex],
        ),
      ),
    );
  }
}
