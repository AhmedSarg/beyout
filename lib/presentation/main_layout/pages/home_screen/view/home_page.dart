import 'package:flutter/material.dart';
import 'package:temp_house/presentation/main_layout/pages/home_screen/view/widgets/home_page_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePageBody(),
    );
  }
}
