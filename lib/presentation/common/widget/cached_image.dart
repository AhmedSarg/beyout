import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
  });

  final String imageUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    String fallback;
    BoxFit fit;
    // fallback = ImageAssets.personImage; ///change this
    fit = BoxFit.cover;
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CircularProgressIndicator(
          value: downloadProgress.progress,
          color: ColorManager.white,
          strokeWidth: AppSize.s1,
          strokeCap: StrokeCap.round,
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error_outline,color: Colors.red,),
    );
  }
}