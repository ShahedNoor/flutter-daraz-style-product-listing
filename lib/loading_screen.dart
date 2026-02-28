import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_daraz_style_product_listing/features/auth/presentation/login_screen.dart';
import 'package:flutter_daraz_style_product_listing/features/auth/presentation/sign_up_screen.dart';
import 'constants/app_constants.dart';
import 'features/product_listing/presentation/product_listing_screen.dart';
import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'helpers/post_login.dart';
import 'networks/dio/dio.dart';
import 'welcome_screen.dart';

final class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isLoading = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    loadInitialData();
    _timer = Timer(const Duration(seconds: 10), () {
      if (_isLoading) {
        // Only log out if internet is connected but loading is taking too long
        _handleLogout();
      }
    });
  }

  loadInitialData() async {
    //AutoAppUpdateUtil.instance.checkAppUpdate();
    await setInitValue();

    if (appData.read(kKeyIsLoggedIn)) {
      String token = appData.read(kKeyAccessToken);
      DioSingleton.instance.update(token);
      await performPostLoginActions();
    } else {
      //  NotificationService().cancelAllNotifications();
    }
    setState(() {
      _timer!.cancel();
      _isLoading = false;
    });
  }

  void _handleLogout() {
    appData.write(kKeyIsLoggedIn, false);

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => LogInScreen()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const WelcomeScreen();
    } else {
      return appData.read(kKeyIsLoggedIn)
          ? const ProductListingScreen()
          : appData.read(kKeyfirstTime)
              ? const SignUpScreen()
              : const LoginScreen();
    }
  }
}
