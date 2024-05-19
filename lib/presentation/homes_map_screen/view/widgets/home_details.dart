import 'package:flutter/material.dart';
import 'package:temp_house/domain/models/domain.dart';

import '../../../resources/values_manager.dart';

class HomeDetails extends StatelessWidget {
  const HomeDetails({
    super.key,
    required this.controller,
    required this.home,
  });

  final ScrollController controller;
  final HomeModel home;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppPadding.p20),
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p50),
              child: Text(home.homeId),
            ),
          ],
        ),
      ),
    );
  }
}
