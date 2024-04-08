import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/common/widget/main_button.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../../../resources/strings_manager.dart';

class RatingDialog extends StatefulWidget {
  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {

  int _rating = 0;
  late TextEditingController _feedbackController;

  @override
  void initState() {
    super.initState();
    _feedbackController = TextEditingController();
  }

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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: AppSize.s10),
          FittedBox(
            child: Row(
              children: [
                RatingStars(
                  onRatingChanged: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
                Text(
                  '$_rating/5 ${AppStrings.feedBackStarRate.tr()}',
                  style: AppTextStyles.feedBackSubHeadTextStyle(context),
                ), // Display current star rating
              ],
            ),
          ),
          const SizedBox(height: AppSize.s20),
          FeedbackText(controller: _feedbackController),
        ],
      ),
      actions: [
        Center(
          child: MainButton(
            backgroundColor: ColorManager.movi,
            text: AppStrings.feedBackBotton.tr(),
            textStyle: AppTextStyles.feedBackBtnTextStyle(context),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }
}

class RatingStars extends StatefulWidget {
  final ValueChanged<int> onRatingChanged;

  RatingStars({required this.onRatingChanged});

  @override
  _RatingStarsState createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars> {
  int _rating = 0;

  void _setRating(int rating) {
    setState(() {
      _rating = rating;
      print('_____________________________________________________');
      print(_rating);
    });
    widget.onRatingChanged(rating);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () => _setRating(index + 1),
          child: Icon(
            Icons.star_rounded,
            size: 40,
            color: index < _rating ? Colors.orange : Colors.grey,
          ),
        );
      }),
    );
  }
}

class FeedbackText extends StatefulWidget {
  final TextEditingController controller;

  FeedbackText({required this.controller});

  @override
  _FeedbackTextState createState() => _FeedbackTextState();
}

class _FeedbackTextState extends State<FeedbackText> {
  final int maxCharacters = 150;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          maxLength: maxCharacters,
          decoration: InputDecoration(
            hintText: AppStrings.feedBackTextHint.tr(),
            border: OutlineInputBorder(),
            errorText: widget.controller.text.length > maxCharacters
                ? 'Feedback exceeds $maxCharacters characters'
                : null,
          ),
          maxLines: 3,
        ),
        const SizedBox(height: AppPadding.p10),
      ],
    );
  }
}
