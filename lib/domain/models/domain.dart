import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;
  final String phoneNumber;
  final String addres;
  final String description;

  PlaceModel(
      this.id,
      this.name,
      this.latLng,
      this.phoneNumber,
      this.addres,
      this.description,
      );
}
