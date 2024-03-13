import 'package:flutter/material.dart';

import 'widgets/register_body_widget.dart';

class RegiesterScreen extends StatelessWidget {
  const RegiesterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RegisterBody(),
    );
  }
}
