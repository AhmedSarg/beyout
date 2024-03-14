import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/routes_manager.dart';
import '../../../../../resources/text_styles.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: Row(
        children: [
          SvgPicture.asset(SVGAssets.pin), // Icon added here
          const SizedBox(width: 4), // Adjust spacing as needed
          Text(
            '39, Fussels lane',
            style: AppTextStyles.authLabelTextStyle(context),
          ),
        ],
      ),
      leading: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(.3),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.person_2_outlined, size: 35, color: Colors.grey),
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.chatRoute);
              },
              child: SvgPicture.asset(SVGAssets.chat)),
          const SizedBox(width: 8),
          SvgPicture.asset(SVGAssets.Bell_pin),
        ],
      ),
    );
  }
}
