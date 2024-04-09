import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/common/widget/main_circle_processIndicator.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';
import 'home_listView_iItem.dart';
import 'no_homes_available.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Home').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MainCicleProcessIndicator();
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          NoHomesAvailable(
            text: AppStrings.NoHomesAvailable.tr(),
          );
        }

        final items = snapshot.data!.docs.map((DocumentSnapshot document) {
          final Map<String, dynamic> data =
              document.data() as Map<String, dynamic>;
          List<dynamic> images = data['images'] ?? [];
          String firstImage = images.isNotEmpty ? images[0] : '';

          String feedbackString = '';
          if (data['feedBack'] is List<dynamic>) {
            List<dynamic> feedbackList = data['feedBack'];
            if (feedbackList.isNotEmpty) {
              feedbackString = feedbackList.join(', ');
            }
          } else if (data['feedBack'] is String) {
            feedbackString = data['feedBack'];
          }

          return BuildCarouselItem(
            color: ColorManager.offwhite,
            title: data['title'],
            price: data['price'],
            location: data['location'],
            imageUrl: firstImage,
            numnerofBeds: data['number_of_bed'],
            wifiServices: data['wifi_services'],
            numnerofbathroom: data['number_of_bedroomd'],
            date: data['category'],
            rate: 2,
            feedBack: feedbackString,
          );
        }).toList();

        return CarouselSlider(
          options: CarouselOptions(
            height: 350,
            aspectRatio: 16 / 9,
            enableInfiniteScroll: true,
            disableCenter: true,
            autoPlay: true,
            enlargeCenterPage: true,
            autoPlayInterval: const Duration(seconds: 10),
            autoPlayAnimationDuration: const Duration(milliseconds: 1200),
            autoPlayCurve: Curves.fastOutSlowIn,
            viewportFraction: 0.70,
            pageSnapping: false,
            scrollDirection: Axis.horizontal,
            initialPage: 0,
          ),
          items: items,
        );
      },
    );
  }
}
