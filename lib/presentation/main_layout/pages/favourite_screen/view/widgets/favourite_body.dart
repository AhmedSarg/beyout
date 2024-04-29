import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:temp_house/presentation/main_layout/pages/home_screen/view/widgets/near_by_home_item.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/routes_manager.dart';

import '../../viewmodel/favourite_viewmodel.dart';

class FavouriteBody extends StatelessWidget {
  const FavouriteBody({Key? key});

  @override
  Widget build(BuildContext context) {
    // final viewModel = Provider.of<FavouriteViewModel>(context, listen: false);

    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.homeDetailsRoute);
          },
          child: NearByHomeItem(
            // onAddToFavorites: () {
            //   // Add your logic here for adding to favorites
            //   viewModel.addToFavorites(userId, homeId); // Pass userId and homeId
            // },
            // onRemoveFromFavorites: () {
            //   // Add your logic here for removing from favorites
            //   viewModel.removeFromFavorites(userId, homeId); // Pass userId and homeId
            // },
          ),
        );
      },
      itemCount: 10,
    );
  }
}
