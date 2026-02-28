import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/colors.gen.dart';

class LoginActionWidget extends StatelessWidget {
  final VoidCallback onLoginTap;
  const LoginActionWidget({super.key, required this.onLoginTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: onLoginTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.cE53935,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              elevation: 0,
            ),
            child: Text(
              "Login",
              style: TextStyle(
                color: AppColors.cFFFFFF,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Center(
          child: TextButton(
            onPressed: () {},
            child: Text(
              "Forgot password?",
              style: TextStyle(
                color: AppColors.c3B5998,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
