import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:temp_house/data/network/app_api.dart';
import 'package:temp_house/domain/models/enums.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';

abstract class RemoteDataSource {
  Future<void> registerTenantToDataBase({
    required String uuid,
    required String username,
    required String email,
    required String phoneNumber,
    required String? password,
    required Gender gender,
    required String job,
    required int salary,
    required int age,
    required String martialStatus,
  });

  Future<void> registerOwnerToDataBase({
    required String uuid,
    required String username,
    required String email,
    required String phoneNumber,
    required String? password,
    required Gender gender,
    required int age,
  });

  Future<void> login({
    required String email,
    required String password,
  });

  Future<void> passwordReset({
    required String email,
  });

  Future<GoogleSignInAccount?> selectGoogleAccount();

  Future<User?> signInWithGoogle(GoogleSignInAccount? googleAccount);

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

  Future<Map<String, dynamic>?> getUserData({
    required String email,
  });

  Future<void> reportHome({
    required String userId,
    required String homeId,
    required String report,
    required DateTime submittedAt,
  });

  Future<void> changeAccountInfo({
    required String userId,
    required String email,
    required String phoneNumber,
    required bool pictureChanged,
    File? picture,
  });

  Future<RegisteredBeforeError?> doesUserExists({
    required String email,
  });

  Future<void> addPaymentCard({
    required String userId,
    required String cardName,
    required String cardNumber,
    required String cardExpirationDate,
  });

  Future<List<Map<String, dynamic>>> getOffers({required String userId});

  Future<Map<String, dynamic>> getUserById({required String userId});

  Future<void> sendOffer({
    required String userId,
    required String ownerId,
    required String homeId,
    required int price,
  });

  Future<void> acceptOffer({
    required String offerId,
    required String userId,
    required String homeId,
  });

  Future<void> declineOffer({required String offerId});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  final FirebaseStorage _firebaseStorage;
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(
    this._firestore,
    this._firebaseAuth,
    this._firebaseStorage,
    this._appServiceClient,
  );

  @override
  Future<void> registerTenantToDataBase({
    required String uuid,
    required String username,
    required String email,
    required String phoneNumber,
    required String? password,
    required Gender gender,
    required String job,
    required int salary,
    required int age,
    required String martialStatus,
  }) async {
    await _firestore.collection('users').doc(uuid).set({
      'id': uuid,
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
      'gender': gender.name,
      'age': age,
      'current_job': job,
      'current_salary': salary,
      'martial_status': martialStatus,
      'user_type': 'tenant',
      'favorites': [],
    });
    if (password != null) {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    }
  }

  @override
  Future<void> registerOwnerToDataBase({
    required String uuid,
    required String username,
    required String email,
    required String phoneNumber,
    required String? password,
    required Gender gender,
    required int age,
  }) async {
    await _firestore.collection('users').doc(uuid).set({
      'id': uuid,
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
      'gender': gender.name,
      'age': age,
      'user_type': 'owner',
      'favorites': [],
    });
    if (password != null) {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    }
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
      'rating': 3.5,
      'numberOfRatings': 1,
      'name': name,
    });

    await docRef.update({'uuid': docRef.id});

    return docRef.id;
  }

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> passwordReset({
    required String email,
  }) async {
    await _firebaseAuth.sendPasswordResetEmail(
      email: email,
    );
  }

  // Future<void> passwordReset() async {
  //
  //   try {
  //     await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //   }
  // }

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
    return _firestore
        .collection('Homes')
        .where('sold', isEqualTo: false)
        .snapshots()
        .map(
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

  @override
  Future<Map<String, dynamic>?> getUserData({
    required String email,
  }) async {
    Map<String, dynamic>? user;
    await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get()
        .then(
      (value) {
        user = value.docs.firstOrNull?.data();
      },
    );
    return user;
  }

  @override
  Future<void> reportHome({
    required String userId,
    required String homeId,
    required String report,
    required DateTime submittedAt,
  }) async {
    await _firestore.collection('Homes').doc(homeId).collection('reports').add(
      {
        'userId': userId,
        'content': report,
        'submitted_at': submittedAt,
      },
    );
  }

  @override
  Future<void> changeAccountInfo({
    required String userId,
    required String email,
    required String phoneNumber,
    required bool pictureChanged,
    File? picture,
  }) async {
    DocumentReference docRef = _firestore.collection('users').doc(userId);

    // Step 1: Update Firestore with email and phone number
    await docRef.update({
      'email': email,
      'phone_number': phoneNumber,
    });

    User? user = _firebaseAuth.currentUser;

    if (user != null && email != user.email) {
      try {
        await user.updateEmail(email);
      } catch (e) {
        print('Failed to update email in FirebaseAuth: $e');

        await docRef.update({
          'email': user.email,
        });
        return;
      }
    }

    if (pictureChanged) {
      String picturePath = '$userId-picture';
      late TaskSnapshot imageUrl;
      await docRef.get().then(
        (value) async {
          imageUrl = await _firebaseStorage
              .ref('user_images')
              .child(picturePath)
              .putFile(
                picture!,
                SettableMetadata(contentType: 'image/jpeg'),
              );
        },
      );
      await docRef.update({
        'image_path': await imageUrl.ref.getDownloadURL(),
      });
    }
    await docRef.update({
      'email': email,
      'phone_number': phoneNumber,
    });
  }

  // @override
  // Future<void> changeAccountInfo({
  //   required String userId,
  //   required String email,
  //   required String phoneNumber,
  //   required bool pictureChanged,
  //   File? picture,
  // }) async {
  //   DocumentReference docRef = _firestore.collection('users').doc(userId);
  //
  //   if (pictureChanged) {
  //     String picturePath = '$userId-picture';
  //     late TaskSnapshot imageUrl;
  //     await docRef.get().then(
  //       (value) async {
  //         imageUrl = await _firebaseStorage
  //             .ref('user_images')
  //             .child(picturePath)
  //             .putFile(
  //               picture!,
  //               SettableMetadata(contentType: 'image/jpeg'),
  //             );
  //       },
  //     );
  //     await docRef.update({
  //       'image_path': await imageUrl.ref.getDownloadURL(),
  //     });
  //   }
  //   await docRef.update({
  //     'email': email,
  //     'phone_number': phoneNumber,
  //   });
  // }

  @override
  Future<RegisteredBeforeError?> doesUserExists({
    required String email,
  }) async {
    bool emailUsed = false;
    await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get()
        .then(
      (value) {
        if (value.docs.isNotEmpty) {
          emailUsed = true;
        }
      },
    );

    if (emailUsed) {
      return RegisteredBeforeError.emailUsed;
    } else {
      return null;
    }
  }

  @override
  Future<void> addPaymentCard({
    required String userId,
    required String cardName,
    required String cardNumber,
    required String cardExpirationDate,
  }) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('payment_cards')
        .doc(cardNumber)
        .set(
      {
        'card_name': cardName,
        'card_number': cardNumber,
        'card_expiration_date': cardExpirationDate,
      },
    );
  }

  @override
  Future<Map<String, dynamic>> getUserById({required String userId}) async {
    return await _firestore
        .collection('users')
        .doc(userId)
        .get()
        .then((value) => value.data()!);
  }

  @override
  Future<List<Map<String, dynamic>>> getOffers({
    required String userId,
  }) async {
    return await _firestore.collection('offers').where('owner_id').get().then(
      (value) {
        return value.docs.map((offer) {
          Map<String, dynamic> ret = offer.data();
          ret['id'] = offer.id;
          return ret;
        }).toList();
      },
    );
  }

  @override
  Future<void> sendOffer({
    required String userId,
    required String ownerId,
    required String homeId,
    required int price,
  }) async {
    await _firestore.collection('offers').add({
      'user_id': userId,
      'owner_id': ownerId,
      'home_id': homeId,
      'price': price,
    });
  }

  @override
  Future<void> acceptOffer({
    required String offerId,
    required String userId,
    required String homeId,
  }) async {
    await _firestore.collection('Homes').doc(homeId).update({
      'sold': true,
      'tenant_id': userId,
    });
    await _firestore.collection('offers').doc(offerId).delete();
  }

  @override
  Future<void> declineOffer({required String offerId}) async {
    await _firestore.collection('offers').doc(offerId).delete();
  }

  @override
  Future<GoogleSignInAccount?> selectGoogleAccount() async {
    return await GoogleSignIn().signIn();
  }

  @override
  Future<User?> signInWithGoogle(GoogleSignInAccount? googleAccount) async {
    GoogleSignInAuthentication? googleAuth =
        await googleAccount?.authentication;

    OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    return userCredential.user;
  }
}
