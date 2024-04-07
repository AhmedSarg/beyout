import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:temp_house/presentation/share_post_screen/view/widgets/share_text_field.dart';

import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';

class ImagePickerField extends StatefulWidget {
   ImagePickerField({super.key,});

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  Future<void> _getImagesFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {

      for (var pickedFile in pickedFiles) {

      }
    }
    Navigator.of(context).pop();
  }

  Future<void> _getImagesFromCamera(BuildContext context) async {
    final picker = ImagePicker();
    List<XFile>? pickedFiles = [];

    while (true) {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile == null) break;
      pickedFiles.add(pickedFile);
    }

    if (pickedFiles.isNotEmpty) {
      for (var pickedFile in pickedFiles) {
      }
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,

      alignment: Alignment.bottomLeft,
      children: [
        Container(
          height: AppSize.s120,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(AppSize.s8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               IconButton(
                 onPressed: () {
                   showDialog(
                     context: context,
                     builder: (BuildContext context) {
                       return AlertDialog(

                         content: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             IconButton(
                               icon: const Icon(Icons.photo_library),
                               onPressed: () {
                                 _getImagesFromGallery(context);
                               },
                             ),
                             IconButton(
                               icon: const Icon(Icons.camera_alt),
                               onPressed: () {
                                 _getImagesFromCamera(context);
                               },
                             ),
                           ],
                         ),

                       );
                     },
                   );
                 },
                 icon: const Icon(
                   Icons.add_photo_alternate,
                   size: AppSize.s50,
                   color: Colors.grey,
                 ),
               ),

               Text(AppStrings.addPhotos.tr(),style: AppTextStyles.sharePostTextStyle(context),)
            ],
          ),
        ),
        Positioned(

            bottom: -15,
            child: Text(AppStrings.addPhotosDescription.tr(),style: AppTextStyles.addImagesDescriptionTextStyle(context)))
      ],
    );
  }
}
