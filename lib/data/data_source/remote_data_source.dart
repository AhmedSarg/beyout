import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:temp_house/data/network/app_api.dart';
import 'package:temp_house/domain/models/enums.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';

abstract class RemoteDataSource {
  Future<void> registerTenantToDataBase({
    required String uuid,
    required String username,
    required String email,
    required String phoneNumber,
    required Gender gender,
    required String? job,
    required num? salary,
    required num age,
    required String martialStatus,
  });

  Future<void> registerOwnerToDataBase({
    required String uuid,
    required String username,
    required String email,
    required String phoneNumber,
    required Gender gender,
    required num age,
    required String martialStatus,
  });

  Future<String> saveHomesToDateBase({
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
    required GeoPoint coordinates,
  });

  Future<void> uploadImages(
    List<File> images,
    String homeId,
  );

  Future<Stream<List<Map<String, dynamic>>>> getAllHomes();

  Future<Map<String, dynamic>> calculateTwoPoints(
      LatLng pickup, LatLng destination);

  Future<void> addToFavorites({
    required String userId,
    required String homeId,
  });

  Future<void> removeFromFavorites({
    required String userId,
    required String homeId,
  });

  Future<Stream<List<dynamic>>> getAllFavorites({
    required String userId,
  });

  Future<Map<String, dynamic>> getHomeById({
    required String homeId,
  });
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(
      this._firestore, this._firebaseStorage, this._appServiceClient);

  @override
  Future<String> registerTenantToDataBase({
    required String uuid,
    required String username,
    required String email,
    required String phoneNumber,
    required Gender gender,
    required String? job,
    required num? salary,
    required num age,
    required String martialStatus,
  }) async {
    DocumentReference docRef = await _firestore.collection('users').add({
      'uuid': uuid,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'job': job,
      'salary': salary,
      'age': age,
      'martialStatus': martialStatus,
      'favorites': [],
      'userType': 'tenant',
    });
    return docRef.id;
  }

  @override
  Future<String> registerOwnerToDataBase({
    required String uuid,
    required String username,
    required String email,
    required String phoneNumber,
    required Gender gender,
    required num age,
    required String martialStatus,
  }) async {
    await _firestore.collection('users').doc(uuid).set({
      'uuid': uuid,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'age': age,
      'martialStatus': martialStatus,
      'favorites': [],
      'userType': 'owner',
    });
    return uuid;
  }

  @override
  Future<String> saveHomesToDateBase({
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
    required GeoPoint coordinates,
  }) async {
    DocumentReference docRef = await _firestore.collection('Homes').add({
      'title': title,
      'price': price,
      'area': area,
      'category': category,
      'condition': condition,
      'number_of_beds': numberOfBeds,
      'wifi': wifi,
      'number_of_bathrooms': numberOfBathrooms,
      'description': description,
      'location': location,
      'coordinates': GeoPoint(coordinates.latitude, coordinates.longitude),
      'timestamp': Timestamp.now(),
      'owner_id': DataIntent.getUser().uid,
    });

    await docRef.update({'uuid': docRef.id});

    return docRef.id;
  }

  @override
  Future<void> uploadImages(List<File> images, String homeId) async {
    List<String> imageUrls = [];
    for (File image in images) {
      Reference ref = _firebaseStorage.ref().child(
          'home_images/$homeId-${DateTime.now().millisecondsSinceEpoch}');

      UploadTask uploadTask = ref.putFile(
        image,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      String imageUrl = await (await uploadTask).ref.getDownloadURL();
      imageUrls.add(imageUrl);
    }
    await _firestore
        .collection('Homes')
        .doc(homeId)
        .update({'images': imageUrls});
  }

  @override
  Future<Stream<List<Map<String, dynamic>>>> getAllHomes() async {
    return _firestore.collection('Homes').snapshots().map(
          (homes) => homes.docs
              .map(
                (home) => home.data(),
              )
              .toList(),
        );
  }

  @override
  Future<Map<String, dynamic>> calculateTwoPoints(
      LatLng pointA, LatLng pointB) async {
    return await _appServiceClient.calculateTwoPoints(pointA, pointB);
  }

  @override
  Future<void> addToFavorites({
    required String userId,
    required String homeId,
  }) async {
    await _firestore.collection('users').doc(userId).update({
      'favorites': FieldValue.arrayUnion([homeId]),
    });
  }

  @override
  Future<void> removeFromFavorites({
    required String userId,
    required String homeId,
  }) async {
    await _firestore.collection('users').doc(userId).update({
      'favorites': FieldValue.arrayRemove([homeId]),
    });
  }

  @override
  Future<Stream<List<dynamic>>> getAllFavorites({
    required String userId,
  }) async {
    return _firestore.collection('users').doc(userId).snapshots().map(
          (user) => user.data()!['favorites'],
        );
  }

  @override
  Future<Map<String, dynamic>> getHomeById({
    required String homeId,
  }) async {
    return await _firestore
        .collection('Homes')
        .doc(homeId)
        .get()
        .then((value) => value.data()!);
  }
}
