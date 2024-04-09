import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class RemoteDataSource {
  Future<String> saveDataToFirestore({
    required String title,
    required num price,
    required String category,
    required String condition,
    required int numberOfBeds,
    required bool wifi,
    required int numberOfBathrooms,
    required String description,
    required String location,
    required LatLng coordinates,
  });

  Future<void> uploadImages(
    List<File> images,
    String homeId,
  );
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;

  RemoteDataSourceImpl(this._firestore, this._firebaseStorage);

  @override
  Future<String> saveDataToFirestore({
    required String title,
    required num price,
    required String category,
    required String condition,
    required int numberOfBeds,
    required bool wifi,
    required int numberOfBathrooms,
    required String description,
    required String location,
    required LatLng coordinates,
  }) async {
    DocumentReference docRef = await _firestore.collection('Homes').add({
      'title': title,
      'price': price,
      'category': category,
      'condition': condition,
      'number_of_beds': numberOfBeds,
      'wifi': wifi,
      'number_of_bathrooms': numberOfBathrooms,
      'description': description,
      'location': location,
      'coordinates': GeoPoint(coordinates.latitude, coordinates.longitude),
    });
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
}
