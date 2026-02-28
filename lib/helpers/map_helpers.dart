// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;

// class MapServices {
//   // Singleton instance
//   static final MapServices _instance = MapServices._internal();
//   factory MapServices() => _instance;
//   MapServices._internal();

//   static const String _apiKey = "Your API Key";

//   Future<RouteInfo?> getRouteCoordinates(LatLng origin, LatLng destination,
//       {String travelMode = 'walking'}) async {
//     String url =
//         "https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&mode=$travelMode&alternatives=true&key=$_apiKey";

//     try {
//       var response = await http.get(Uri.parse(url));
//       Map<String, dynamic> values = jsonDecode(response.body);

//       if (values["routes"] != null && values["routes"].isNotEmpty) {
//         // Find the route with the shortest distance
//         var routes = values["routes"] as List;
//         var shortestRoute = routes.reduce((curr, next) {
//           int currDist = curr["legs"][0]["distance"]["value"];
//           int nextDist = next["legs"][0]["distance"]["value"];
//           return currDist < nextDist ? curr : next;
//         });

//         String encodedPoints = shortestRoute["overview_polyline"]["points"];
//         List<LatLng> points = _decodePolyline(encodedPoints);

//         String distance = shortestRoute["legs"][0]["distance"]["text"];
//         String duration = shortestRoute["legs"][0]["duration"]["text"];

//         List<RouteStep> steps = [];
//         if (shortestRoute["legs"][0]["steps"] != null) {
//           for (var step in shortestRoute["legs"][0]["steps"]) {
//             steps.add(RouteStep(
//               instruction: _cleanHtml(step["html_instructions"]),
//               startLocation: LatLng(
//                   step["start_location"]["lat"], step["start_location"]["lng"]),
//               distance: step["distance"]["text"],
//             ));
//           }
//         }

//         return RouteInfo(
//             points: points,
//             distance: distance,
//             duration: duration,
//             steps: steps);
//       }
//     } catch (e) {
//       debugPrint("Error fetching route: $e");
//     }
//     return null;
//   }

//   String _cleanHtml(String html) {
//     RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
//     return html.replaceAll(exp, '');
//   }

//   // Decode Google Polyline encoded string to List<LatLng>
//   List<LatLng> _decodePolyline(String encoded) {
//     List<LatLng> poly = [];
//     int index = 0, len = encoded.length;
//     int lat = 0, lng = 0;

//     while (index < len) {
//       int b, shift = 0, result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1f) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lat += dlat;

//       shift = 0;
//       result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1f) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lng += dlng;

//       poly.add(LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble()));
//     }
//     return poly;
//   }
// }

// class RouteInfo {
//   final List<LatLng> points;
//   final String distance;
//   final String duration;
//   final List<RouteStep> steps;

//   RouteInfo({
//     required this.points,
//     required this.distance,
//     required this.duration,
//     required this.steps,
//   });
// }

// class RouteStep {
//   final String instruction;
//   final LatLng startLocation;
//   final String distance;

//   RouteStep({
//     required this.instruction,
//     required this.startLocation,
//     required this.distance,
//   });
// }
