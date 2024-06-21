import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  Future<Either<Failure, User?>> signInWithGoogle() async {
    try {
      if (await _networkInfo.isConnected) {
        GoogleSignInAccount? googleAccount =
            await _remoteDataSource.selectGoogleAccount();
        bool userExists = (await _remoteDataSource.doesUserExists(
                email: googleAccount!.email)) ==
            RegisteredBeforeError.emailUsed;
        User? user = await _remoteDataSource.signInWithGoogle(googleAccount);
        if (!userExists) {
          DataIntent.pushFireAuthUser(user);
          return Left(DataSource.MISSING_DATA.getFailure());
        } else {
          return Right(user);
        }
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
    required String? password,
    required Gender gender,
    required String? job,
    required int? salary,
    required int age,
    required String? martialStatus,
    required String? image,
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
            password: password,
            gender: gender,
            job: job!,
            salary: salary!,
            age: age,
            martialStatus: martialStatus!,
            image: image,
          );
        } else {
          await _remoteDataSource.registerOwnerToDataBase(
            uuid: uuid,
            phoneNumber: phoneNumber,
            email: email,
            password: password,
            username: username,
            gender: gender,
            age: age,
            image: image,
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
        void response;
        await _remoteDataSource.login(
          email: email,
          password: password,
        );
        await fetchCurrentUser(email);
        return Right(response);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } on FirebaseAuthException {
      return Left(DataSource.LOGIN_FAILED.getFailure());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> passwordReset({
    required String email,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        void response;
        await _remoteDataSource.passwordReset(
          email: email,
        );
        fetchCurrentUser(email);
        return Right(response);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } on FirebaseAuthException {
      return Left(DataSource.LOGIN_FAILED.getFailure());
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
  Future<Either<Failure, User?>> fetchCurrentUser([String? email]) async {
    try {
      print(1);
      if (await _networkInfo.isConnected) {
        print(2);
        var data = _cacheDataSource.getSignedUser();
        print(3);
        print(data?.email);
        if (data != null) {
          print(4);
          Map<String, dynamic>? userData = await _remoteDataSource.getUserData(
            email: data.email!,
          );
          print(5);
          print(userData);
          UserModel userModel = UserModel.fromMap(userData!);
          print(6);
          print(userModel.username);
          DataIntent.pushUser(userModel);
          print(7);
          if (userData['user_type'].toLowerCase() == 'owner') {
            print(8);
            DataIntent.setUserRole(UserRole.owner);
          } else {
            print(9);
            DataIntent.setUserRole(UserRole.tenant);
          }
          print(10);
        }
        print(11);
        return Right(data);
      } else {
        print(12);
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      print(13);
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> reportHome({
    required String userId,
    required String homeId,
    required String report,
    required DateTime submittedAt,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.reportHome(
          userId: userId,
          homeId: homeId,
          report: report,
          submittedAt: submittedAt,
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
  Future<Either<Failure, void>> changeAccountInfo({
    required String userId,
    required String username,
    required String phoneNumber,
    required bool pictureChanged,
    File? picture,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.changeAccountInfo(
          userId: userId,
          username: username,
          phoneNumber: phoneNumber,
          pictureChanged: pictureChanged,
          picture: picture,
        );
        await fetchCurrentUser(DataIntent.getUser().email);
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> addPaymentCard({
    required String userId,
    required String cardName,
    required String cardNumber,
    required String cardExpirationDate,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.addPaymentCard(
          userId: userId,
          cardName: cardName,
          cardNumber: cardNumber,
          cardExpirationDate: cardExpirationDate,
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
  Future<Either<Failure, List<Future<OfferModel>>>> getOffers({
    required String ownerId,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        List<Future<OfferModel>> offers =
            await _remoteDataSource.getOffers(userId: ownerId).then(
          (offersMap) {
            return offersMap.map(
              (offerMap) async {
                Map<String, dynamic> homeMap =
                    await _remoteDataSource.getHomeById(
                  homeId: offerMap['home_id'],
                );
                Map<String, dynamic> userMap =
                    await _remoteDataSource.getUserById(
                  userId: offerMap['user_id'],
                );
                offerMap['home'] = homeMap;
                offerMap['user'] = userMap;
                return OfferModel.fromMap(offerMap);
              },
            ).toList();
          },
        );
        return Right(offers);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> sendOffer({
    required String userId,
    required String ownerId,
    required String homeId,
    required int price,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.sendOffer(
          userId: userId,
          ownerId: ownerId,
          homeId: homeId,
          price: price,
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
  Future<Either<Failure, void>> acceptOffer({
    required String offerId,
    required String userId,
    required String homeId,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.acceptOffer(
          offerId: offerId,
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
  Future<Either<Failure, void>> declineOffer({required String offerId}) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.declineOffer(offerId: offerId);
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      void response;
      await _cacheDataSource.logout();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
