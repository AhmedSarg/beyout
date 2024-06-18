import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/font_manager.dart';
import 'package:temp_house/presentation/search_screen/view/widgets/search_home_item.dart';

import '../../../../domain/models/domain.dart';
import '../../../common/data_intent/data_intent.dart';
import '../../../common/widget/empty_list.dart';
import '../../../common/widget/main_circle_processIndicator.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';

class CheapestSearch extends StatelessWidget {
  const CheapestSearch({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Homes')
          .orderBy('price')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MainCicleProcessIndicator();
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return Center(
              child: EmptyListItem(
            content: AppStrings.emptyData.tr(),
            image: SVGAssets.delete,
            style: AppTextStyles.homeGeneralTextStyle(
                context, ColorManager.offwhite, FontSize.f22),
          ));
        }

        final items = snapshot.data!.docs.map((DocumentSnapshot document) {
          final Map<String, dynamic> data =
              document.data()! as Map<String, dynamic>;
          List<dynamic> images = data['images'] ?? [];
          String firstImage = images.isNotEmpty ? images[0] : '';

          return GestureDetector(
            onTap: () {
              DataIntent.pushHome(HomeModel.fromMap(data));
              Navigator.pushNamed(context, Routes.homeDetailsRoute);
            },
            child: SearchHomeItem(
              home: HomeModel.fromMap(data),
            ),
          );
        }).toList();

        return ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return items[index];
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              indent: 22,
              thickness: .5,
              endIndent: 22,
              color: Colors.grey,
            );
          },
        );
      },
    );
  }
}
