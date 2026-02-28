import 'package:flutter/material.dart';
import 'package:flutter_daraz_style_product_listing/constants/validator.dart';
import 'package:flutter_daraz_style_product_listing/helpers/loading_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/text_font_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/navigation_service.dart';
import '../../../helpers/ui_helpers.dart';
import '../../../networks/api_acess.dart';
import '../../../common_widgets/custom_rich_text_button.dart';
import '../../../common_widgets/custom_textform_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.verticalSpaceSmall,
                Text(
                  "Create Account",
                  style: TextStyle(
                    color: AppColors.c111827,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                Text(
                  "Join Daraz today.",
                  style: TextFontStyle.textStyle14c6B7280Inter400,
                ),
                UIHelper.verticalSpaceSemiLarge,
                Center(
                  child: Assets.icons.appIcon.image(
                    height: 90.h,
                    width: 90.h,
                  ),
                ),
                UIHelper.verticalSpaceSemiLarge,
                // Email Field
                CustomTextFormField(
                  controller: _emailController,
                  hintText: "Email",
                  validator: emailValidator,
                  hintStyle: TextFontStyle.textStyle14c6B7280Inter400,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: AppColors.cD1D5DB, width: 1.w),
                  focusedBorderSide:
                      BorderSide(color: const Color(0xFFE53935), width: 1.w),
                ),
                UIHelper.verticalSpaceMedium,
                // Username Field
                CustomTextFormField(
                  controller: _usernameController,
                  hintText: "Username",
                  validator: nameValidator,
                  hintStyle: TextFontStyle.textStyle14c6B7280Inter400,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: AppColors.cD1D5DB, width: 1.w),
                  focusedBorderSide:
                      BorderSide(color: const Color(0xFFE53935), width: 1.w),
                ),
                UIHelper.verticalSpaceMedium,
                // Password Field
                CustomTextFormField(
                  controller: _passwordController,
                  isPassword: true,
                  hintText: "Password",
                  validator: passwordValidator,
                  hintStyle: TextFontStyle.textStyle14c6B7280Inter400,
                  fillColor: AppColors.cF3F4F6,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                  borderRadius: BorderRadius.zero,
                  borderSide: const BorderSide(color: Colors.transparent),
                  focusedBorderSide:
                      BorderSide(color: const Color(0xFFE53935), width: 1.w),
                ),
                UIHelper.verticalSpace(30.h),
                // Sign Up Action Widget
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        postSignUpRxObj
                            .postSignUp(
                              email: _emailController.text,
                              username: _usernameController.text,
                              password: _passwordController.text,
                            )
                            .waitingForFutureWithoutBg()
                            .then((value) {
                          if (value) {
                            NavigationService.navigateToUntilReplacement(
                                Routes.loginScreen);
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cE53935,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: AppColors.cFFFFFF,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                UIHelper.verticalSpaceSemiLarge,
                Center(
                  child: Column(
                    children: [
                      CustomRichTextButton(
                        onPressed: () =>
                            NavigationService.navigateToUntilReplacement(
                                Routes.loginScreen),
                        additionalText: "Already have an account? ",
                        additionalTextStyle: TextStyle(
                          color: AppColors.c6B7280,
                          fontSize: 14.sp,
                        ),
                        buttonText: "Login",
                        buttonTextStyle: TextStyle(
                          color: const Color(0xFF3B5998),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpace(30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
