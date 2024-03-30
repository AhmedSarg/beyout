// //Home Screen
// class NewsItemModel {
//   final int id;
//   final String title;
//   final String desc;
//   final String img;
//
//   const NewsItemModel({
//     required this.id,
//     required this.title,
//     required this.desc,
//     required this.img,
//   });
// }
//
// class NewsListModel {
//   final List<NewsItemModel> news;
//
//   const NewsListModel({
//     required this.news,
//   });
// }
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModel(this.id, this.name, this.latLng);
}

