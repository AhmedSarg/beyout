import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:temp_house/presentation/common/widget/main-divider.dart';
import 'package:temp_house/presentation/common/widget/main_circle_processIndicator.dart';
import 'package:temp_house/presentation/main_layout/pages/home_screen/view/widgets/home_listView_iItem.dart';
import '../../../../common/widget/main_app_bar.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/text_styles.dart';

class AllPopularHome extends StatelessWidget {
  const AllPopularHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(
        context,
        Text(
          AppStrings.popularStartedTextRow.tr(),
          style: AppTextStyles.loginTitleTextStyle(context),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Home').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MainCicleProcessIndicator();
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final items = snapshot.data!.docs.map((DocumentSnapshot document) {
            final Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            List<dynamic> images = data['images'] ?? [];
            String firstImage = images.isNotEmpty ? images[0] : '';

            return BuildCarouselItem(
              color: ColorManager.offwhite,
              title: data['title'],
              price: data['price'],
              location: data['location'],
              imageUrl: firstImage,
              numnerofBeds: data['number_of_bed'],
              wifiServices: data['wifi_services'],
              numnerofbathroom: data['number_of_bedroomd'], date: data['category'],
            );
          }).toList();

          return ListView.separated(
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
      ),
    );
  }
}
