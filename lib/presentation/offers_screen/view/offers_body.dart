import 'package:flutter/material.dart';
import 'package:temp_house/presentation/offers_screen/viewmodel/offers_viewmodel.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

class OffersBody extends StatelessWidget {
  const OffersBody({super.key});

  static late OffersViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = OffersViewModel.get(context);
    return SizedBox(
      width: AppSize.infinity,
      child: ListView.builder(
        itemBuilder: (context, index) {},
      ),
    );
  }
}
