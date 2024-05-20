import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/domain.dart';
import '../../domain/models/enums.dart';
import '../../domain/repository/repository.dart';
import '../data_source/cache_data_source.dart';
import '../data_source/remote_data_source.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;

  final CacheDataSource _cacheDataSource;
  final NetworkInfo _networkInfo;

  final Uuid _uuidGenerator = const Uuid();

  RepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
    this._cacheDataSource,
  );

  @override
  Future<Either<Failure, void>> sharePost({
    required String title,
    required String name,
    required num price,
    required num area,
    required String category,
    required String condition,
    required int numberOfBeds,
    required bool wifi,
    required int numberOfBathrooms,
    required String description,
    required String location,
    required List<File> images,
    required GeoPoint coordinates,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        String homeId = await _remoteDataSource.saveHomesToDateBase(
          title: title,
          price: price,
          area: area,
          category: category,
          condition: condition,
          numberOfBeds: numberOfBeds,
          wifi: wifi,
          numberOfBathrooms: numberOfBathrooms,
          description: description,
          location: location,
          coordinates: coordinates,
          name: name,
        );
        await _remoteDataSource.uploadImages(images, homeId);
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> register({
    required String username,
    required String email,
    required String phoneNumber,
    required Gender gender,
    required String? job,
    required int? salary,
    required int age,
    required String? martialStatus,
    required UserRole userType,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        String uuid = _uuidGenerator.v1();
        if (userType == UserRole.tenant) {
          await _remoteDataSource.registerTenantToDataBase(
            uuid: uuid,
            phoneNumber: phoneNumber,
            email: email,
            username: username,
            gender: gender,
            job: job!,
            salary: salary!,
            age: age,
            martialStatus: martialStatus!,
          );
        } else {
          await _remoteDataSource.registerOwnerToDataBase(
            uuid: uuid,
            phoneNumber: phoneNumber,
            email: email,
            username: username,
            gender: gender,
            age: age,
          );
        }
        await fetchCurrentUser(email);
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.login(email: email, password: password);
        await fetchCurrentUser(email);
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Stream<List<HomeModel>>>> getAllHomes() async {
    try {
      if (await _networkInfo.isConnected) {
        Stream<List<HomeModel>> homesStream =
            await _remoteDataSource.getAllHomes().then(
          (stream) {
            return stream.map(
              (homes) {
                return homes.map(
                  (home) {
                    return HomeModel.fromMap(home);
                  },
                ).toList();
              },
            );
          },
        );
        return Right(homesStream);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> calculateTwoPoints({
    required LatLng pointA,
    required LatLng pointB,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        Map<String, dynamic> res =
            await _remoteDataSource.calculateTwoPoints(pointA, pointB);
        return Right(res);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> addToFavorites({
    required String userId,
    required String homeId,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.addToFavorites(userId: userId, homeId: homeId);
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorites({
    required String userId,
    required String homeId,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.removeFromFavorites(
          userId: userId,
          homeId: homeId,
        );
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Stream<List<Future<HomeModel>>>>> getAllFavorites({
    required String userId,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        Stream<List<Future<HomeModel>>> favoriteHomesStream =
            await _remoteDataSource
                .getAllFavorites(
          userId: userId,
        )
                .then(
          (homesStream) {
            return homesStream.map(
              (homes) {
                return homes.map(
                  (homeId) async {
                    final home = await _remoteDataSource.getHomeById(
                      homeId: homeId,
                    );
                    return HomeModel.fromMap(home);
                  },
                ).toList();
              },
            );
          },
        );
        return Right(favoriteHomesStream);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, User?>> fetchCurrentUser(
      [String email = 'xsarg22@gmail.com']) async {
    try {
      if (await _networkInfo.isConnected) {
        print('in fetch');
        //todo uncomment the 2 lines below
        //var data = _cacheDataSource.getSignedUser();
        //if (data != null) {
        Map<String, dynamic> userData = await _remoteDataSource.getUserData(
          email: email,
          //todo uncomment the line below and remove the line above
          //email: data.email!,
        );
        print(userData);
        UserModel userModel = UserModel.fromMap(userData);
        print(userModel.username);
        DataIntent.pushUser(userModel);
        if (userData['user_type'].toLowerCase() == 'owner') {
          DataIntent.setUserRole(UserRole.owner);
        } else {
          DataIntent.setUserRole(UserRole.tenant);
        }
      }
      //todo remove this
      return const Right(null);
      //todo uncomment the 4 lines below
      //return Right(data);
      //} else {
      //  return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      //}
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
