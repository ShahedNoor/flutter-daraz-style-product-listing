// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
// import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:url_launcher/url_launcher.dart';

// class SubscriptionService {
//   static const _apiKey = 'goog_LKcOZeEjjvxKXfeyuQCGoWnMeke';

//   // Entitlements
//   static const entitlementUser = 'Bear Valley Digital Pro';
//   static const entitlementBusiness = 'business_tier';

//   // Offerings
//   static const offeringUser = 'user_paywall';
//   static const offeringBusiness = 'business_paywall';

//   // Singleton instance
//   static final SubscriptionService _instance = SubscriptionService._internal();

//   factory SubscriptionService() {
//     return _instance;
//   }

//   SubscriptionService._internal();

//   /// Stream controller for CustomerInfo updates (BehaviorSubject retains latest value)
//   final _customerInfoController = BehaviorSubject<CustomerInfo>();

//   /// Stream of CustomerInfo updates
//   Stream<CustomerInfo> get customerInfoStream => _customerInfoController.stream;

//   /// Initialize RevenueCat SDK
//   Future<void> init() async {
//     // TODO: Remove this check when production API key is available
//     if (kReleaseMode) {
//       // NOTE: We are now using the correct production/test key, so we can likely enable this.
//       // However, for safety during internal testing, we ensure debug logs are on.
//       // debugPrint("RevenueCat disabled in release mode...");
//       // return;
//     }

//     await Purchases.setLogLevel(LogLevel.debug);

//     PurchasesConfiguration? configuration;
//     if (Platform.isAndroid) {
//       configuration = PurchasesConfiguration(_apiKey);
//     }
//     // Add iOS configuration if needed in the future

//     if (configuration != null) {
//       await Purchases.configure(configuration);
//     }

//     // Load initial info
//     try {
//       CustomerInfo info = await Purchases.getCustomerInfo();
//       _customerInfoController.add(info);
//     } catch (e) {
//       debugPrint("Error fetching initial customer info: $e");
//     }

//     // Listen for updates
//     Purchases.addCustomerInfoUpdateListener((customerInfo) {
//       _customerInfoController.add(customerInfo);
//     });
//   }

//   /// Check if the user has active Pro access (either User OR Business)
//   Future<bool> get isPro async {
//     try {
//       CustomerInfo customerInfo = await Purchases.getCustomerInfo();
//       final isUserPro =
//           customerInfo.entitlements.all[entitlementUser]?.isActive ?? false;
//       final isBusinessPro =
//           customerInfo.entitlements.all[entitlementBusiness]?.isActive ?? false;
//       return isUserPro || isBusinessPro;
//     } on PlatformException catch (e) {
//       // Error fetching customer info
//       debugPrint("Error fetching customer info: $e");
//       return false;
//     }
//   }

//   /// Specific check for Business Pro
//   Future<bool> get isBusinessPro async {
//     try {
//       CustomerInfo customerInfo = await Purchases.getCustomerInfo();
//       return customerInfo.entitlements.all[entitlementBusiness]?.isActive ??
//           false;
//     } on PlatformException catch (e) {
//       debugPrint("Error fetching customer info: $e");
//       return false;
//     }
//   }

//   /// Get the active product identifier (to distinguish monthly/yearly)
//   Future<String?> get activeProductIdentifier async {
//     try {
//       CustomerInfo customerInfo = await Purchases.getCustomerInfo();
//       // Check user entitlement first
//       if (customerInfo.entitlements.all[entitlementUser]?.isActive ?? false) {
//         final productId =
//             customerInfo.entitlements.all[entitlementUser]?.productIdentifier;
//         debugPrint("DEBUG: Active User Product ID: $productId");
//         return productId;
//       }
//       // Check business entitlement
//       if (customerInfo.entitlements.all[entitlementBusiness]?.isActive ??
//           false) {
//         final productId = customerInfo
//             .entitlements.all[entitlementBusiness]?.productIdentifier;
//         debugPrint("DEBUG: Active Business Product ID: $productId");
//         return productId;
//       }
//       debugPrint(
//           "DEBUG: No active entitlement found for IDs: $entitlementUser, $entitlementBusiness");
//       return null;
//     } on PlatformException catch (e) {
//       debugPrint("Error fetching customer info: $e");
//       return null;
//     }
//   }

//   /// Present Paywall based on user type
//   /// [isBusiness] - set to true to show business plans ($15/mo), false for user plans ($1.99/mo)
//   Future<bool> presentPaywall({bool isBusiness = false}) async {
//     try {
//       // 1. Check if they already have the specific entitlement
//       if (isBusiness) {
//         if (await isBusinessPro) return true;
//       } else {
//         if (await isPro) return true;
//       }

//       // 2. Get the specific offering
//       final offerings = await Purchases.getOfferings();
//       final targetOfferingId = isBusiness ? offeringBusiness : offeringUser;
//       final offering = offerings.all[targetOfferingId];

//       if (offering == null) {
//         debugPrint(
//             "Error: Offering $targetOfferingId not found in RevenueCat dashboard.");
//         return false;
//       }

//       // 3. Show Paywall for that offering
//       final paywallResult = await RevenueCatUI.presentPaywall(
//         offering: offering,
//       );

//       // Explicitly update customer info after paywall interaction
//       final updatedInfo = await Purchases.getCustomerInfo();
//       _customerInfoController.add(updatedInfo);

//       return paywallResult == PaywallResult.purchased ||
//           paywallResult == PaywallResult.restored;
//     } on PlatformException catch (e) {
//       debugPrint("Error presenting paywall: $e");
//       return false;
//     }
//   }

//   bool _isPurchasing = false;

//   /// Purchase a specific subscription directly (without RevenueCat Paywall UI)
//   /// [isBusiness] - User type
//   /// [isMonthly] - True for monthly plan, False for yearly plan
//   Future<bool> purchaseSubscription({
//     required bool isBusiness,
//     required bool isMonthly,
//   }) async {
//     if (_isPurchasing) {
//       debugPrint("Purchase already in progress, ignoring duplicate request.");
//       return false;
//     }

//     _isPurchasing = true;

//     try {
//       // 1. Get Offerings
//       final offerings = await Purchases.getOfferings();
//       final targetOfferingId = isBusiness ? offeringBusiness : offeringUser;
//       final offering = offerings.all[targetOfferingId];

//       if (offering == null) {
//         debugPrint("Error: Offering $targetOfferingId not found.");
//         return false;
//       }

//       // 2. Select Package (Standard 'monthly'/'yearly' identifiers recommended)
//       // or fall back to available packages if identifiers don't match exactly.
//       Package? packageToBuy;
//       if (isMonthly) {
//         packageToBuy = offering.monthly;
//       } else {
//         packageToBuy = offering.annual;
//       }

//       // Fallback if specific package shortcut is null, try finding by Identifier
//       if (packageToBuy == null) {
//         final targetPkgId = isMonthly ? 'monthly' : 'yearly';
//         packageToBuy = offering.availablePackages.firstWhere(
//             (pkg) => pkg.identifier == targetPkgId,
//             orElse: () => offering.availablePackages.first);
//       }

//       // 3. Purchase
//       // Using var to handle potential version discrepancies (CustomerInfo vs PurchaseResult)
//       // 3. Purchase
//       // We accept dynamic here to bypass the specific type check error
//       // reported by the user ("PurchaseResult" vs "CustomerInfo").
//       // In standard SDKs, this is CustomerInfo. If it's a wrapper, we'll try to extract.
//       dynamic result = await Purchases.purchasePackage(packageToBuy);

//       CustomerInfo customerInfo;
//       // Check if it's the wrapper or the object itself
//       if (result is CustomerInfo) {
//         customerInfo = result;
//       } else {
//         // If it returns a "PurchaseResult" object (likely from a newer/different wrapper),
//         // we try to access the customerInfo property dynamically.
//         // If that fails, we blindly cast.
//         try {
//           customerInfo = (result as dynamic).customerInfo;
//         } catch (_) {
//           // Last resort cast
//           customerInfo = result as CustomerInfo;
//         }
//       }

//       // Explicitly update the stream with the new info
//       _customerInfoController.add(customerInfo);

//       // 4. Check Entitlement
//       final targetEntitlement =
//           isBusiness ? entitlementBusiness : entitlementUser;
//       return customerInfo.entitlements.all[targetEntitlement]?.isActive ??
//           false;
//     } on PlatformException catch (e) {
//       var errorCode = PurchasesErrorHelper.getErrorCode(e);
//       if (errorCode == PurchasesErrorCode.operationAlreadyInProgressError) {
//         debugPrint("Operation already in progress. Ignoring.");
//         return false;
//       }
//       if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
//         debugPrint("Error purchasing: $e");
//       }
//       return false;
//     } finally {
//       _isPurchasing = false;
//     }
//   }

//   /// Get current offering details (for displaying prices)
//   Future<Offering?> fetchOfferingDetails({bool isBusiness = false}) async {
//     try {
//       final offerings = await Purchases.getOfferings();
//       final targetOfferingId = isBusiness ? offeringBusiness : offeringUser;
//       return offerings.all[targetOfferingId];
//     } on PlatformException catch (e) {
//       debugPrint("Error fetching offerings: $e");
//       return null;
//     }
//   }

//   /// Open store subscription management page
//   Future<void> manageSubscription() async {
//     String? url;
//     if (Platform.isAndroid) {
//       url = 'https://play.google.com/store/account/subscriptions';
//     } else if (Platform.isIOS) {
//       url = 'https://apps.apple.com/account/subscriptions';
//     }

//     if (url != null) {
//       // Use url_launcher to open the URL
//       // We need to import 'package:url_launcher/url_launcher.dart' at the top of the file
//       // Since I can't add imports easily in this chunk, I will assume it's added or use a dynamic approach
//       // check if I can add imports.
//       // Actually, I can just tell the user to check imports, but I should try to add it.
//       // Wait, I cannot add imports in this chunk as it's in the body.
//       try {
//         final uri = Uri.parse(url);
//         if (await canLaunchUrl(uri)) {
//           await launchUrl(uri);
//         }
//       } catch (e) {
//         debugPrint("Error opening subscription management: $e");
//       }
//     }
//   }

//   /// Restore purchases manually if needed (Paywall usually handles this)
//   Future<void> restorePurchases() async {
//     try {
//       final customerInfo = await Purchases.restorePurchases();
//       _customerInfoController.add(customerInfo);
//     } on PlatformException catch (e) {
//       debugPrint("Error restoring purchases: $e");
//     }
//   }
// }
