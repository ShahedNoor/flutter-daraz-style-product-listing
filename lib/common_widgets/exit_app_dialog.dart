import 'dart:io';
import 'package:flutter/material.dart';
import '../../constants/text_font_style.dart';
import '../../gen/colors.gen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExitAppDialog extends StatelessWidget {
  const ExitAppDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Exit App',
              style: TextFontStyle.textStyle14c0A192FInter600
                  .copyWith(fontSize: 16.sp),
            ),
            SizedBox(height: 16.h),
            Text(
              'Are you sure you want to exit the app?',
              textAlign: TextAlign.center,
              style: TextFontStyle.textStyle14c4B5563Inter400,
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.c6B7280),
                      minimumSize: Size(double.infinity, 44.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextFontStyle.textStyle14c4B5563Inter400,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => exit(0),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cDarazOrange,
                      minimumSize: Size(double.infinity, 44.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      "Exit",
                      style: TextFontStyle.textStyle14c0A192FInter600
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
