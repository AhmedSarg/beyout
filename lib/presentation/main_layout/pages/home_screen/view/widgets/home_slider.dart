import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';
import 'home_listView_iItem.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Home').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading indicator
        }
        if (snapshot.hasError) {
          return Center(
              child: Text('Error: ${snapshot.error}')); // Show error message
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text(
              'No data available'); // Show message if no data available
        }

        final items = snapshot.data!.docs.map((DocumentSnapshot document) {
          final Map<String, dynamic> data =
              document.data() as Map<String, dynamic>;
          List<dynamic> images = data['images'] ?? [];
          String firstImage = images.isNotEmpty ? images[0] : '';

          return buildCarouselItem(
            color: ColorManager.offwhite,
            text: data['title'],
            title: data['title'],
            price: data['price'],
            location: data['location'],
            imageUrl: firstImage,
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
          items: items, // Pass the list of CarouselItems
        );
      },
    );
  }
}
