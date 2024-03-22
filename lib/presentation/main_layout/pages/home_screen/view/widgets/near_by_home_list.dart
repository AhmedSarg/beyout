import 'package:flutter/material.dart';

import 'near_by_home_item.dart';

class NearByHomeList extends StatelessWidget {
  const NearByHomeList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 700,
        mainAxisExtent: 150,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,

      ),
      itemBuilder: (context, index) {

        return const Padding(
          padding: EdgeInsets.all( 10.0),
          child: NearByHomeItem(),
        );
      },
    );
  }
}
