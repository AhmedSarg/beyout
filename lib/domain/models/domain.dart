import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;
  final String phoneNumber;
  final String address;
  final String description;

  PlaceModel(
    this.id,
    this.name,
    this.latLng,
    this.phoneNumber,
    this.address,
    this.description,
  );
}

class HomeModel {
  final String title;
  final String homeId;
  final String ownerId;
  final num price;
  final String location;
  final String imageUrl;
  final int numberOfBeds;
  final bool wifiServices;
  final int numberOfBathrooms;
  final DateTime date;
  final String description;
  final LatLng coordinates;
  final double rate;
  final int numberOfRates;
  final String rentPeriod;

  HomeModel({
    required this.title,
    required this.price,
    required this.location,
    required this.imageUrl,
    required this.numberOfBeds,
    required this.wifiServices,
    required this.numberOfBathrooms,
    required this.date,
    required this.description,
    required this.coordinates,
    required this.homeId,
    required this.ownerId,
    required this.rate,
    required this.numberOfRates,
    required this.rentPeriod,
  });

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      title: map['title'],
      price: map['price'],
      location: map['location'],
      imageUrl: map['images'][0],
      numberOfBeds: map['number_of_beds'],
      wifiServices: map['wifi'],
      numberOfBathrooms: map['number_of_bathrooms'],
      date: map['timestamp'].toDate(),
      description: map['description'],
      coordinates: LatLng(
        map['coordinates'].latitude,
        map['coordinates'].longitude,
      ),
      homeId: map['uuid'],
      ownerId: map['owner_id'],
      rate: map['rating'].toDouble(),
      numberOfRates: map['numberOfRatings'],
      rentPeriod: map['category'],
    );
  }
}

class User {
  final String uid;
  final String email;
  final String name;
  final List<String> favoriteHomes;

  User({
    required this.uid,
    required this.email,
    required this.name,
    required this.favoriteHomes,
  });

  addHomeToFavorites(String homeId) {
    favoriteHomes.add(homeId);
  }

  removeHomeFromFavorites(String homeId) {
    favoriteHomes.remove(homeId);
  }

  bool isHomeInFavorites(String homeId) {
    return favoriteHomes.contains(homeId);
  }
}
