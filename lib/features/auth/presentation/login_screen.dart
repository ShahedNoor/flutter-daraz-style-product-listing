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
import '../../../common_widgets/custom_rich_text_button.dart';
import '../../../common_widgets/custom_textform_field.dart';
import '../../../networks/api_acess.dart';
import '../widgets/login_action_widget.dart';
import '../widgets/login_header_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
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
                const LoginHeaderWidget(),
                UIHelper.verticalSpaceSemiLarge,
                Center(
                  child: Assets.icons.appIcon.image(
                    height: 90.h,
                    width: 90.h,
                  ),
                ),
                UIHelper.verticalSpaceSemiLarge,
                // Email / Phone Field
                CustomTextFormField(
                  controller: _emailController,
                  hintText: "Email/Phone",
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
                LoginActionWidget(
                  onLoginTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      postLoginRxObj
                          .postLogin(
                            username: _emailController.text,
                            password: _passwordController.text,
                          )
                          .waitingForFutureWithoutBg()
                          .then((value) {
                        NavigationService.navigateToUntilReplacement(
                            Routes.productListingScreen);
                      });
                    }
                  },
                ),
                UIHelper.verticalSpaceSemiLarge,
                Center(
                  child: Column(
                    children: [
                      CustomRichTextButton(
                        onPressed: () {
                          NavigationService.navigateToUntilReplacement(
                              Routes.signUpScreen);
                        },
                        additionalText: "Haven't Signed Up Yet? ",
                        additionalTextStyle: TextStyle(
                          color: AppColors.c6B7280,
                          fontSize: 14.sp,
                        ),
                        buttonText: "Sign Up",
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
