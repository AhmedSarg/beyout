import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/routes_manager.dart';

import 'widgets/home_page_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.primary,
        shape: const OvalBorder(),
        onPressed: () {
Navigator.pushNamed(context, Routes.publishHomePostRoute);
        },
        child: const Icon(
          Icons.add,
          color: ColorManager.white,
          size: 28,
        ),
      ),
      body: const HomePageBody(),
    );
  }
}
