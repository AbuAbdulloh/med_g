import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:med_g/app/constants/app_images.dart';
import 'package:med_g/app/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  const CachedImage({
    required this.fit,
    required this.url,
    required this.width,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fit,
      width: width,
      height: height,
      imageUrl: url,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          Shimmer.fromColors(
        child: Container(
          width: 80,
          height: 80,
          color: white,
        ),
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
      ),
      errorWidget: (context, url, error) => Image.asset(
        AppImages.errorPlaceholder,
      ),
    );
  }
}
