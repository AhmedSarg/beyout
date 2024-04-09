import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/repository/repository.dart';
import '../data_source/remote_data_source.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  // final LocalDataSource _localDataSource;
  // final CacheDataSource _cacheDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(
    this._remoteDataSource,
    // this._localDataSource,
    this._networkInfo,
    // this._cacheDataSource,
  );

  @override
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
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        String homeId = await _remoteDataSource.saveDataToFirestore(
          title: title,
          price: price,
          category: category,
          condition: condition,
          numberOfBeds: numberOfBeds,
          wifi: wifi,
          numberOfBathrooms: numberOfBathrooms,
          description: description,
          location: location,
          coordinates: coordinates,
        );
        await _remoteDataSource.uploadImages(images, homeId);
        return const Right(null);
      }
      else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
