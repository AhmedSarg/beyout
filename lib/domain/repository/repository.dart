import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:temp_house/domain/models/domain.dart';

import '../../data/network/failure.dart';
import '../models/enums.dart';

abstract class Repository {
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
  });

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
    required UserRole userType,
  });

  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> passwordReset({
    required String email,
  });

  Future<Either<Failure, User?>> signInWithGoogle();

  Future<Either<Failure, Stream<List<HomeModel>>>> getAllHomes();

  Future<Either<Failure, Map<String, dynamic>>> calculateTwoPoints({
    required LatLng pointA,
    required LatLng pointB,
  });

  Future<Either<Failure, void>> addToFavorites({
    required String userId,
    required String homeId,
  });

  Future<Either<Failure, void>> removeFromFavorites({
    required String userId,
    required String homeId,
  });

  Future<Either<Failure, Stream<List<Future<HomeModel>>>>> getAllFavorites({
    required String userId,
  });

  Future<Either<Failure, User?>> fetchCurrentUser();

  Future<Either<Failure, void>> reportHome({
    required String userId,
    required String homeId,
    required String report,
    required DateTime submittedAt,
  });

  Future<Either<Failure, void>> changeAccountInfo({
    required String userId,
    required bool emailChanged,
    required String email,
    required String phoneNumber,
    required bool pictureChanged,
    File? picture,
  });

  Future<Either<Failure, void>> addPaymentCard({
    required String userId,
    required String cardName,
    required String cardNumber,
    required String cardExpirationDate,
  });

  Future<Either<Failure, List<Future<OfferModel>>>> getOffers({
    required String ownerId,
  });

  Future<Either<Failure, void>> sendOffer({
    required String userId,
    required String ownerId,
    required String homeId,
    required int price,
  });

  Future<Either<Failure, void>> acceptOffer({
    required String offerId,
    required String userId,
    required String homeId,
  });

  Future<Either<Failure, void>> declineOffer({required String offerId});

  Future<Either<Failure, void>> logout();

}
