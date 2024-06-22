import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';

import '../../app/sl.dart';
import 'view/widgets/selection_body.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        onPopInvoked: (didPop) {
          if (DataIntent.getFireAuthUser() != null) {
            DataIntent.deleteFireAuthUser();
            sl<FirebaseAuth>().signOut();
          }
        },
        child: const SelectionBody(),
      ),
    );
  }
}
