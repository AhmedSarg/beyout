import 'package:flutter/material.dart';
import 'package:temp_house/presentation/common/widget/main-divider.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import 'near_by_home_item.dart';

class NearByHomeList extends StatelessWidget {
  const NearByHomeList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return const NearByHomeItem();
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: AppSize.s20,
          child: MainDivider(),
        );
      },
    );
  }
}
