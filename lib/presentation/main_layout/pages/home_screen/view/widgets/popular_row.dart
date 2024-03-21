import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../../../resources/text_styles.dart';

class PopularRow extends StatelessWidget {
  const PopularRow({super.key, this.startedText, this.endedText, required this.RowStartedcolor,  required this.RowEndedcolor});
  final String? startedText;
  final String? endedText;
  final Color RowStartedcolor;
  final Color RowEndedcolor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(startedText??"",style:AppTextStyles.PopularRowStartedTextStyle(context,RowStartedcolor) ,),
          Text(endedText??"",style: AppTextStyles.PopularRowEndedTextStyle(context,RowEndedcolor),),
        ],
      ),
    );
    ;
  }
}
