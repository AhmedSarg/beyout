import 'package:cloud_firestore/cloud_firestore.dart';

class HomeServices{
  void saveDataToFirestore({
    String? title,
    double? price,
    String? category,
    String? condition,
    String? description,
    String? location,
    List<String>? images,
  }) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference homes = firestore.collection('Home');

    Map<String, dynamic> data = {
      'title': title,
      'price': price,
      'category': category,
      'condition': condition,
      'description': description,
      'location': location,
      'images': images,
    };

    homes.add(data)
        .then((value) {
      print("Data added successfully!");
    })
        .catchError((error) {

      print("Failed to add data: $error");
    });
  }
}