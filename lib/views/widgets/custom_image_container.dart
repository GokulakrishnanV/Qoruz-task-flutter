import 'package:cached_network_image/cached_network_image.dart' show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:qoruz/utils/constants/colors.dart';

class NetworkImageContainer extends StatelessWidget {
  const NetworkImageContainer({super.key, required this.imageUrl, this.height, this.width, this.borderRadius, this.decoration, this.child});

  final String imageUrl;
  final double? height;
  final double? width;
  final double? borderRadius;
  final BoxDecoration? decoration;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder:
          (context, imageProvider) => Container(
            height: height,
            width: width,
            decoration: (decoration ?? BoxDecoration()).copyWith(
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
            ),
          ),
      placeholder:
          (context, url) => Container(
            height: height,
            width: width,
            decoration: BoxDecoration(color: GenericColors.grey, borderRadius: BorderRadius.circular(borderRadius ?? 10.0)),
            child: const Icon(Icons.image_outlined, color: GenericColors.darkGrey),
          ),
      errorWidget:
          (context, url, error) => Container(
            height: height,
            width: width,
            decoration: BoxDecoration(color: GenericColors.grey, borderRadius: BorderRadius.circular(borderRadius ?? 10.0)),
            child: const Icon(Icons.error_outline_rounded, color: GenericColors.darkGrey),
          ),
    );
  }
}
