// lib/common_widgets/generic_cached_image.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;
  final BorderRadiusGeometry? borderRadius;
  final Color placeholderColor;
  final Color errorColor;
  final Widget? customPlaceholder;
  final Widget? customErrorWidget;
  final double placeholderIconSize;
  final double errorIconSize;
  final BoxBorder? border;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholderColor = const Color(0xFFF5F5F5),
    this.errorColor = const Color(0xFFE8E8E8),
    this.customPlaceholder,
    this.customErrorWidget,
    this.placeholderIconSize = 24,
    this.errorIconSize = 32,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (imageUrl.isEmpty) {
      child = customErrorWidget ?? _buildErrorWidget();
    } else if (!imageUrl.startsWith('http')) {
      child = Image.asset(
        imageUrl,
        height: height?.h,
        width: width?.w,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            customErrorWidget ?? _buildErrorWidget(),
      );
    } else {
      child = CachedNetworkImage(
        imageUrl: imageUrl,
        height: height?.h,
        width: width?.w,
        fit: fit,
        fadeInDuration: const Duration(milliseconds: 300),
        fadeOutDuration: const Duration(milliseconds: 300),
        placeholder: (context, url) => customPlaceholder ?? _buildPlaceholder(),
        errorWidget: (context, url, error) =>
            customErrorWidget ?? _buildErrorWidget(),
      );
    }

    return Container(
      // decoration: BoxDecoration(
      //   borderRadius: borderRadius,

      // ),
      foregroundDecoration: BoxDecoration(
        border: border,
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: child,
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height?.h,
        width: width?.w,
        color: placeholderColor,
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      height: height?.h,
      width: width?.w,
      color: errorColor,
      child: Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          size: errorIconSize.sp,
          color: Colors.grey[500],
        ),
      ),
    );
  }
}
