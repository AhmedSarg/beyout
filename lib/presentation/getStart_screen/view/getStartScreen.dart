import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/getStart_screen/view/widgets/getStartBody.dart';

import '../../resources/strings_manager.dart';
import '../../resources/text_styles.dart';

class GetStartScreen extends StatelessWidget {
  const GetStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetStartBody(),);
  }
}
