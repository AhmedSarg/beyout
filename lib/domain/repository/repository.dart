import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:temp_house/data/network/failure.dart';

abstract class Repository {
  Future<Either<Failure, void>> sharePost({
    required String title,
    required num price,
    required String category,
    required String condition,
    required int numberOfBeds,
    required bool wifi,
    required int numberOfBathrooms,
    required String description,
    required String location,
    required List<File> images,
    required LatLng coordinates,
  });
}
