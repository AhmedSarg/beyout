import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/common/widget/main_button.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/font_manager.dart';

import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';

class RatingDialog extends StatefulWidget {
  final String homeItemId;

  RatingDialog({required this.homeItemId});

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _rating = 0;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(
            AppStrings.feedBackHeader.tr(),
            style: AppTextStyles.feedBackHeaderTextStyle(context),
          ),
          Text(
            AppStrings.feedBackSubHead.tr(),
            style: AppTextStyles.feedBackSubHeadTextStyle(context),
          ),
        ],
      ),
      content: _isLoading
          ? const CircularProgressIndicator(
              color: ColorManager.offwhite,
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      onPressed: () {
                        setState(() {
                          _rating = index + 1;
                        });
                      },
                      icon: Icon(
                        index < _rating ? Icons.star : Icons.star_border,
                        color: index < _rating ? ColorManager.orange : null,
                      ),
                    );
                  }),
                ),
              ],
            ),
      actions: [
        SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            child: ElevatedButton(
                onPressed: _isLoading ? null : _submitRating,
                child: Text(AppStrings.submit.tr()))),
      ],
    );
  }

  Future<void> _submitRating() async {
    setState(() {
      _isLoading = true;
    });

    final docSnapshot = await FirebaseFirestore.instance
        .collection('Homes')
        .doc(widget.homeItemId)
        .get();

    if (docSnapshot.exists) {
      await FirebaseFirestore.instance
          .collection('Homes')
          .doc(widget.homeItemId)
          .update({
        'rating': FieldValue.increment(_rating),
        'numberOfRatings': FieldValue.increment(1),
      });
    } else {
      print('Document not found in Firestore');
    }

    setState(() {
      _isLoading = false;
    });

    Navigator.pop(context);
  }
}
