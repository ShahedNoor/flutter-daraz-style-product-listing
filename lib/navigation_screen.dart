// import 'package:custom_navigation_bar/custom_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_daraz_style_product_listing/features/auth/presentation/login_screen.dart';

// import 'common_widgets/app_network_image.dart';
// import 'constants/text_font_style.dart';
// import 'gen/colors.gen.dart';
// import 'helpers/helper_methods.dart';

// class NavigationScreen extends StatefulWidget {
//   final Widget? pageNum;
//   const NavigationScreen({
//     super.key,
//     this.pageNum,
//   });

//   @override
//   State<NavigationScreen> createState() => _NavigationScreenState();
// }

// class _NavigationScreenState extends State<NavigationScreen> {
//   int _currentIndex = 0;

//   final bool _isFisrtBuild = true;
//   late final List<Widget> _screens;

//   @override
//   void initState() {
//     super.initState();
//     _screens = [
//       const LoginScreen(),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     Object? args;
//     StatefulWidget? screenPage;
//     if (_isFisrtBuild) {
//       args = ModalRoute.of(context)!.settings.arguments;
//     }
//     if (args != null) {
//       screenPage = args as StatefulWidget;
//       var newColorindex = -1;

//       for (var element in _screens) {
//         newColorindex++;
//         if (element.toString() == screenPage.toString()) {
//           _currentIndex = newColorindex;
//           break;
//         }
//       }
//     }

//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (bool didPop, _) async {
//         showMaterialDialog(context);
//       },
//       child: Scaffold(
//         backgroundColor: AppColors.cFFFFFF,
//         body: Center(
//           child: (screenPage != null)
//               ? screenPage
//               : _screens.elementAt(_currentIndex),
//         ),
//         bottomNavigationBar: ColoredBox(
//           color: AppColors.cFFFFFF,
//           child: SafeArea(
//             child: SizedBox(
//               height: 80.h,
//               child: CustomNavigationBar(
//                 iconSize: 24.r,
//                 strokeColor: AppColors.primaryColor,
//                 backgroundColor: AppColors.cFFFFFF,
//                 items: [
//                   CustomNavigationBarItem(
//                       title: Text(
//                         "Auth",
//                         style: _currentIndex == 0
//                             ? TextFontStyle.textStyle12c00BFA5Inter500
//                             : TextFontStyle.textStyle12c6B7280Inter400,
//                       ),
//                       icon: const Icon(Icons.home)),
//                 ],
//                 currentIndex: _currentIndex,
//                 onTap: (index) {
//                   setState(() {
//                     _currentIndex = index;
//                   });
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPackageNavItem(
//     int index,
//     String selectedAsset,
//     String unselectedAsset, {
//     bool isProfile = false,
//   }) {
//     bool isSelected = _currentIndex == index;

//     if (isProfile) {
//       return AppNetworkImage(
//         imageUrl: selectedAsset,
//         height: 28.r,
//         width: 28.r,
//         borderRadius: BorderRadius.circular(100.r),
//         border: isSelected
//             ? Border.all(
//                 color: AppColors.primaryColor,
//                 width: 2.w,
//               )
//             : null,
//       );
//     }

//     return Image.asset(
//       isSelected ? selectedAsset : unselectedAsset,
//       height: 24.r,
//       width: 24.r,
//       fit: BoxFit.contain,
//     );
//   }
// }
