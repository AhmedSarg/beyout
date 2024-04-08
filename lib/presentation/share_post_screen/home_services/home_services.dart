import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomeServices {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Future<void> saveDataToFirestore({
    required String title,
    required num price,
    required String category,
    required String condition,
    required String description,
    required String location,
    required List<File> images,
  }) async {
    try {
      List<String> imageUrls = await _uploadImages(images);

      await _firestore.collection('Home').add({
        'title': title,
        'price': price,
        'category': category,
        'condition': condition,
        'description': description,
        'location': location,
        'images': imageUrls,
      });

      print("Data added successfully!");
    } catch (error) {
      print("Failed to add data: $error");
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
