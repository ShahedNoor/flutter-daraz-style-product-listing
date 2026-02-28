import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_daraz_style_product_listing/helpers/ui_helpers.dart';
import '/constants/text_font_style.dart';
import '/gen/colors.gen.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.isTealButton,
    this.isOutline = false,
    required this.onPressed,
    required this.title,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.height,
    this.width,
    this.textStyle,
    this.textColor,
    this.padding,
    this.gradient,
    this.boxShadow,
    this.border,
    this.icon,
    this.isIconLeft = false,
  });

  final VoidCallback? onPressed;
  final String title;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BorderRadiusGeometry? borderRadius;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final bool? isTealButton;
  final bool isOutline;
  final Widget? icon;
  final bool isIconLeft;

  @override
  Widget build(BuildContext context) {
    final bool isTeal = isTealButton ?? false;

    Gradient? effectiveGradient;
    List<BoxShadow>? effectiveBoxShadow;
    BoxBorder? effectiveBorder;
    Color? effectiveBackgroundColor;
    Color? effectiveForegroundColor;

    if (isTeal) {
      if (isOutline) {
        effectiveBackgroundColor = Colors.transparent;
        effectiveBorder = Border.all(color: AppColors.primaryColor, width: 1.w);
        effectiveForegroundColor = AppColors.primaryColor;
      } else {
        effectiveBackgroundColor = AppColors.primaryColor;
        effectiveForegroundColor = AppColors.cFFFFFF;
      }
    } else {
      effectiveGradient = gradient;
      effectiveBoxShadow = boxShadow;
      effectiveBorder = border;
      effectiveBackgroundColor = backgroundColor;
      effectiveForegroundColor = foregroundColor;
    }

    final bool useContainer = effectiveGradient != null ||
        effectiveBoxShadow != null ||
        effectiveBorder != null;

    final Widget buttonContent = isLoading
        ? SizedBox(
            width: 20.w,
            height: 20.h,
            child: CircularProgressIndicator(
              strokeWidth: 2.w,
              valueColor: AlwaysStoppedAnimation<Color>(
                effectiveForegroundColor ?? AppColors.cFFFFFF,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null && isIconLeft) ...[
                icon!,
                UIHelper.horizontalSpace(10.w),
              ],
              Text(
                title,
                style: textStyle ??
                    TextFontStyle.textStyle18cFFFFFFInter600.copyWith(
                      color: effectiveForegroundColor ?? AppColors.cFFFFFF,
                    ),
                textAlign: TextAlign.center,
              ),
              if (icon != null && !isIconLeft) ...[
                UIHelper.horizontalSpace(10.w),
                icon!,
              ],
            ],
          );

    final ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: useContainer
          ? Colors.transparent
          : (effectiveBackgroundColor ?? AppColors.primaryColor),
      foregroundColor: effectiveForegroundColor ?? AppColors.cFFFFFF,
      shadowColor: useContainer ? Colors.transparent : null,
      disabledBackgroundColor:
          (effectiveBackgroundColor ?? AppColors.primaryColor)
              .withValues(alpha: 0.5),
      disabledForegroundColor: (effectiveForegroundColor ?? AppColors.cFFFFFF)
          .withValues(alpha: 0.5),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(12.r),
      ),
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
    );

    Widget elevatedButton = SizedBox(
      width: width ?? double.infinity,
      height: height ?? 52.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: style,
        child: buttonContent,
      ),
    );

    if (useContainer || effectiveBorder != null) {
      return Container(
        width: width,
        height: height ?? 52.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: effectiveGradient,
          boxShadow: effectiveBoxShadow,
          borderRadius: borderRadius ?? BorderRadius.circular(12.r),
          border: effectiveBorder,
          color: effectiveGradient == null ? effectiveBackgroundColor : null,
        ),
        child: elevatedButton,
      );
    }

    return elevatedButton;
  }
}

// Alternative function-style customButton
Widget customButton({
  required VoidCallback? onPressed,
  required String title,
  bool isLoading = false,
  Color? backgroundColor,
  Color? foregroundColor,
  BorderRadiusGeometry? borderRadius,
  double? height,
  double? width,
  TextStyle? textStyle,
  EdgeInsetsGeometry? padding,
  Gradient? gradient,
  List<BoxShadow>? boxShadow,
  BoxBorder? border,
  bool? isTealButton,
  bool isOutline = false,
  Widget? icon,
  bool isIconLeft = false,
}) {
  return CustomButton(
    onPressed: onPressed,
    title: title,
    isLoading: isLoading,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    borderRadius: borderRadius,
    height: height,
    width: width,
    textStyle: textStyle,
    padding: padding,
    gradient: gradient,
    boxShadow: boxShadow,
    border: border,
    isTealButton: isTealButton,
    isOutline: isOutline,
    icon: icon,
    isIconLeft: isIconLeft,
  );
}
