import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';

import '../../resources/text_styles.dart';

class SocialContainer extends StatelessWidget {
  const SocialContainer({super.key, required this.title, required this.image});
final String title;
final String  image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: ColorManager.darkGrey.withOpacity(.15),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 4),
            child: ClipOval(child: SvgPicture.asset(image,width: 40,height: 40,)),
          ),
          Text(
            title,
            style: AppTextStyles.authSocialTextStyle(context),
          ),
        ],
      ),
    );
  }
}
