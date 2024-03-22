import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';

class ImagePickerField extends StatelessWidget {
  const ImagePickerField({super.key});

  Future<void> _getImageFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // Handle picked image file
    if (pickedFile != null) {
      // Do something with the picked image file
    }
    Navigator.of(context).pop(); // Close the dialog
  }

  Future<void> _getImageFromCamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    // Handle picked image file
    if (pickedFile != null) {
      // Do something with the picked image file
    }
    Navigator.of(context).pop(); // Close the dialog
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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
                    title: Text('Choose an option'),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.photo_library),
                          onPressed: () {
                            _getImageFromGallery(context);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: () {
                            _getImageFromCamera(context);
                          },
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(
              Icons.add_photo_alternate,
              size: AppSize.s50,
              color: Colors.grey,
            ),
          ),
           Text('Add Photos',style: AppTextStyles.sharePostTextStyle(context),)
        ],
      ),
    );
  }
}
