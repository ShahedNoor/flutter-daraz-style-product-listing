import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/text_font_style.dart';
import '../../../gen/colors.gen.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hi !\nwelcome to daraz",
          style: TextFontStyle.textStyle26c0A192FInter600.copyWith(
            height: 1.2,
            fontSize: 24.sp,
            color: AppColors.c000000,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          "Please log in with email and password.",
          style: TextFontStyle.textStyle14c4B5563Inter400.copyWith(
            fontSize: 14.sp,
            color: AppColors.c4B5563,
          ),
        ),
      ],
    );
  }
}
