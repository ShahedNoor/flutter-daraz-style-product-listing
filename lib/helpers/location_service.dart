// import 'dart:developer';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import '../constants/app_constants.dart';
// import 'di.dart';

// // need to add permisson for both android and ios

// class LocationService {
//   // Private static instance (Singleton pattern)
//   static final LocationService _singleton = LocationService._internal();

//   // Private constructor
//   LocationService._internal();

//   // Public factory constructor
//   static LocationService get instance => _singleton;

//   // Boolean variable to track location permission status
//   bool isLocationPermissionGranted = false;
//   // Boolean variable to track location service status
//   bool isLocationServiceEnabled = false;

//   // Flag to indicate if location permission has been checked
//   bool isLocationPermissionChecked = false;

//   Future<void>? _initializationFuture;

//   // Method to initialize GetStorage and check for location permission
//   // requestPermission: If true, will request permission if not granted. If false, will only check status.
//   Future<void> initialize(
//       {bool requestPermission = true, bool updateLocation = true}) async {
//     if (_initializationFuture != null) {
//       await _initializationFuture;
//       return;
//     }
//     _initializationFuture = _checkLocationPermission(
//         requestPermission: requestPermission, updateLocation: updateLocation);
//     try {
//       await _initializationFuture;
//     } finally {
//       _initializationFuture = null;
//     }
//   }

//   // Method to check and handle location permission
//   Future<void> _checkLocationPermission(
//       {bool requestPermission = true, bool updateLocation = true}) async {
//     // Check if location services are enabled
//     isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

//     if (!isLocationServiceEnabled) {
//       isLocationPermissionGranted =
//           false; // Cannot be granted if service is off
//       isLocationPermissionChecked = true;
//       return;
//     }

//     LocationPermission permission = await Geolocator.checkPermission();

//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       if (requestPermission) {
//         permission = await Geolocator.requestPermission();
//       } else {
//         // Just update status without requesting
//         isLocationPermissionGranted = false;
//         isLocationPermissionChecked = true;
//         return;
//       }

//       if (permission == LocationPermission.denied) {
//         // If permission is denied, update the boolean variable
//         isLocationPermissionGranted = false;
//         isLocationPermissionChecked = true;
//         return;
//       } else if (permission == LocationPermission.deniedForever) {
//         // Open app settings if permission is permanently denied
//         // await Geolocator.openAppSettings();
//         isLocationPermissionGranted = false;
//         isLocationPermissionChecked = true;
//         return;
//       }
//     }

//     // If permission is granted, update the boolean variable and fetch the current location
//     isLocationPermissionGranted = true;
//     if (updateLocation) {
//       await _updateLocation();
//     }
//     isLocationPermissionChecked = true;
//   }

//   // Method to update location and save to GetStorage
//   Future<void> _updateLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           locationSettings:
//               const LocationSettings(accuracy: LocationAccuracy.high));

//       // Save the latitude and longitude to GetStorage
//       await appData.write(kKeySelectedLat, position.latitude);
//       await appData.write(kKeySelectedLng, position.longitude);

//       // Get location name from coordinates
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(position.latitude, position.longitude);

//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks[0];
//         String locationName =
//             "${place.street}, ${place.administrativeArea}, ${place.country}";

//         // Save location name to GetStorage
//         await appData.write(kKeySelectedLocation, locationName);

//         log("Location updated: Lat: ${position.latitude}, Long: ${position.longitude}, Name: $locationName");
//       } else {
//         log("No placemarks found");
//       }
//     } catch (e) {
//       log("Error fetching location: $e");
//     }
//   }

//   // Method to return location name from coordinates
//   Future<String?> getLocationNameFromCoordinates(
//       double lat, double long) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks[0];
//         String locationName =
//             "${place.street}, ${place.administrativeArea}, ${place.country}";

//         return locationName;
//       } else {
//         log("No placemarks found");
//         return null;
//       }
//     } catch (e) {
//       log("Error fetching location: $e");
//       return null;
//     }
//   }

//   // Method to calculate the distance using saved lat/long and given lat/long
//   String? calculateDistance(double lat, double long) {
//     try {
//       double? savedLat = appData.read(kKeySelectedLat);
//       double? savedLong = appData.read(kKeySelectedLng);

//       if (savedLat == null || savedLong == null) {
//         log("Location data is not available in storage.");
//         return null;
//       }

//       // Calculate distance using Geolocator
//       double distanceInMeters = Geolocator.distanceBetween(
//         savedLat,
//         savedLong,
//         lat,
//         long,
//       );

//       // Convert to a more readable format (meters or kilometers)
//       if (distanceInMeters < 1000) {
//         return "${distanceInMeters.toInt()}m"; // For distances less than 1 km, show in meters
//       } else {
//         double distanceInKilometers = distanceInMeters / 1000;
//         return "${distanceInKilometers.toInt()}km"; // For distances greater than 1 km, show in kilometers
//       }
//     } catch (e) {
//       log("Error calculating distance: $e");
//       return null;
//     }
//   }
// }
