import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_daraz_style_product_listing/gen/colors.gen.dart';
import '/constants/text_font_style.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final String? Function(String?)? validator;
  final bool isPassword;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final bool readOnly;
  final VoidCallback? onTextFormFieldTap;
  final Color? borderColor;
  final int? maxLines;
  final TextAlign textAlign;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final BorderSide? borderSide;
  final BorderSide? focusedBorderSide;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.hintStyle,
    this.labelText,
    this.validator,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputAction,
    this.keyboardType,
    this.fillColor,
    this.readOnly = false,
    this.onTextFormFieldTap,
    this.borderColor,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.borderRadius,
    this.contentPadding,
    this.borderSide,
    this.focusedBorderSide,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTextFormFieldTap,
      readOnly: widget.readOnly,
      cursorColor: AppColors.c0A192F,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _obscureText,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      textAlign: widget.textAlign,
      style: TextFontStyle.textStyle14c0A192FInter400,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ?? TextFontStyle.textStyle14c6B7280Inter400,
        labelText: widget.labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: Center(child: widget.prefixIcon),
                ),
              )
            : null,
        suffixIcon: widget.isPassword
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: Icon(
                      _obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.c6B7280,
                      size: 24.sp,
                    ),
                  ),
                ),
              )
            : widget.suffixIcon != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: widget.suffixIcon,
                    ),
                  )
                : null,
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(
              vertical: 14.h,
              horizontal: 14.w,
            ),
        filled: true,
        fillColor: widget.fillColor ?? AppColors.cFFFFFF,
        border: OutlineInputBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
          borderSide: widget.borderSide ??
              BorderSide(
                color: widget.borderColor ?? AppColors.cF3F4F6,
              ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
          borderSide: widget.borderSide ??
              BorderSide(
                color: widget.borderColor ?? AppColors.cF3F4F6,
              ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
          borderSide: widget.focusedBorderSide ??
              widget.borderSide ??
              const BorderSide(color: AppColors.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.cDC2626),
        ),
      ),
    );
  }
}
