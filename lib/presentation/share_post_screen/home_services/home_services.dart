import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeServices {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Future<String> saveDataToFirestore({
    required String title,
    required num price,
    required String category,
    required String condition,
    required String numberOfBed,
    required String wifiServices,
    required String numberOfBedrooms,
    required String description,
    required String location,
    required List<File> images,
    required double latitude,
    required double longitude,
  }) async {
    try {
      List<String> imageUrls = await _uploadImages(images);

      DocumentReference docRef = await _firestore.collection('Home').add({
        'title': title,
        'price': price,
        'category': category,
        'condition': condition,
        'number_of_bed': numberOfBed,
        'wifi_services': wifiServices,
        'number_of_bedroomd': numberOfBedrooms,
        'description': description,
        'location': location,
        'images': imageUrls,
        'latitude': latitude,
        'longitude': longitude,
      });

      print("Data added successfully!");
      return docRef.id;
    } catch (error) {
      print("Failed to add data: $error");
      return '';
    }
  }


  Future<void> saveUsersFeedBackToFirestore({
    required String homeId,
    required String feedback,
  }) async {
    try {
      await _firestore.collection('Home').doc(homeId).update({
        'feedback': FieldValue.arrayUnion([feedback]),
      });

      print("Feedback added successfully!");
    } catch (error) {
      print("Failed to add feedback: $error");
    }
  }

  Future<List<String>> _uploadImages(List<File> images) async {
    List<String> imageUrls = [];

    for (File image in images) {
      Reference ref = _storage.ref().child('Home_images/${DateTime.now().millisecondsSinceEpoch}');

      UploadTask uploadTask = ref.putFile(image);

      String imageUrl = await (await uploadTask).ref.getDownloadURL();

      imageUrls.add(imageUrl);
    }

    return imageUrls;
  }
}
