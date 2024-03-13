import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';

import '../../resources/color_manager.dart';
import '../../resources/text_styles.dart';

class SocialContainer extends StatelessWidget {
  const SocialContainer({super.key, required this.title});
final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: ColorManager.offwhite.withOpacity(.2),
      ),
      child: Row(
        children: [
          SvgPicture.asset(SVGAssets.facebook,),
          Text(
            title,
            style: AppTextStyles.authSocialTextStyle(context),
          ),
        ],
      ),
    );
  }
}
