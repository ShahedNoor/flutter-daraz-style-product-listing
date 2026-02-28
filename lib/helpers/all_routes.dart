// ignore_for_file: unused_element

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_daraz_style_product_listing/features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/sign_up_screen.dart';
import '../features/product_listing/presentation/product_listing_screen.dart';

final class Routes {
  static final Routes _routes = Routes._internal();
  Routes._internal();
  static Routes get instance => _routes;

  // Onboarding Routes
  static const String onboardingWrapper = '/onboardingWrapper';

  static const String loginScreen = '/login';
  static const String signInScreen = '/signIn';
  static const String signUpScreen = '/signUp';
  static const String termsAndConditionsScreen = '/termsAndConditions';
  static const String locationAccessScreen = '/locationAccess';
  static const String interestSelectionScreen = '/interestSelection';
  static const String forgotPasswordScreen = '/forgotPassword';
  static const String emailVerificationScreen = '/emailVerification';

  static const String createNewPasswordScreen = '/createNewPassword';
  static const String passwordResetSuccessScreen = '/passwordResetSuccess';

  // Home Routes
  static const String homeScreen = '/homeScreen';
  static const String productListingScreen = '/productListingScreen';
  static const String productDetailsScreen = '/productDetailsScreen';
  static const String matchScreen = '/matchScreen';

  // Profile Routes
  static const String profileScreen = '/profileScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String myListingScreen = '/myListingScreen';
  static const String notificationsScreen = '/notificationsScreen';
  static const String settingsScreen = '/settingsScreen';
  static const String notificationPreferencesScreen =
      '/notificationPreferencesScreen';
  static const String privacySettingsScreen = '/privacySettingsScreen';
  static const String locationSettingsScreen = '/locationSettingsScreen';
  static const String changePasswordScreen = '/changePassword';
  static const String helpAndSupportScreen = '/helpAndSupport';
  static const String faqScreen = '/faqScreen';
  static const String contactSupportScreen = '/contactSupportScreen';
  static const String appTermsAndConditionsScreen = '/appTermsAndConditions';
  static const String myReviewsScreen = '/myReviewsScreen';
  static const String itemDetailsScreen = '/itemDetailsScreen';

  // Product Routes
  static const String addProductScreen = '/addProductScreen';
  static const String addItemDetailsScreen = '/addItemDetailsScreen';
  static const String addLocationAndAvailabilityScreen =
      '/addLocationAndAvailabilityScreen';
  static const String previewScreen = '/previewScreen';
  static const String itemIsLiveScreen = '/itemIsLiveScreen';
  static const String bostYourItemScreen = '/bostYourItemScreen';
  static const String garageSaleDetailsScreen = '/garageSaleDetailsScreen';
  static const String addItemsScreen = '/addItemsScreen';
  static const String garageSalePreviewScreen = '/garageSalePreviewScreen';
  static const String garageSaleCheckoutScreen = '/garageSaleCheckoutScreen';
  static const String garageSaleIsLiveScreen = '/garageSaleIsLiveScreen';
  static const String garageItemsScreen = '/garageItemsScreen';

  // Chat Routes
  static const String sellerChatDetailScreen = '/sellerChatDetailScreen';
  static const String sellerChatScreen = '/sellerChatScreen';
  static const String buyerMessageScreen = '/buyerMessageScreen';
  static const String reportIssueScreen = '/reportIssueScreen';
  static const String thanksForLettingUsKnowScreen =
      '/thanksForLettingUsKnowScreen';
  static const String interestedUsersScreen = '/interestedUsersScreen';

  // Navigation Routes
  static const String navigationScreen = '/navigationScreen';
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();
  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth Routes
      case Routes.loginScreen:
        return defaultTargetPlatform == TargetPlatform.iOS
            ? CupertinoPageRoute(builder: (context) => const LoginScreen())
            : _FadedTransitionRoute(
                widget: const LoginScreen(), settings: settings);
      case Routes.signUpScreen:
        return defaultTargetPlatform == TargetPlatform.iOS
            ? CupertinoPageRoute(builder: (context) => const SignUpScreen())
            : _FadedTransitionRoute(
                widget: const SignUpScreen(), settings: settings);

      // case Routes.navigationScreen:
      //   return defaultTargetPlatform == TargetPlatform.iOS
      //       ? CupertinoPageRoute(builder: (context) => const NavigationScreen())
      //       : _FadedTransitionRoute(
      //           widget: const NavigationScreen(), settings: settings);

      case Routes.productListingScreen:
        return defaultTargetPlatform == TargetPlatform.iOS
            ? CupertinoPageRoute(
                builder: (context) => const ProductListingScreen())
            : _FadedTransitionRoute(
                widget: const ProductListingScreen(), settings: settings);

      default:
        return null;
    }
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
      : super(
          settings: settings,
          reverseTransitionDuration: const Duration(milliseconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 1),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.ease,
              ),
              child: child,
            );
          },
        );
}

class ScreenTitle extends StatelessWidget {
  final Widget widget;

  const ScreenTitle({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: .5, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: widget,
    );
  }
}
