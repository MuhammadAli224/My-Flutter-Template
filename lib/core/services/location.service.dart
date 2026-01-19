// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../../feature/citizen/saved_location/domain/entities/location_entity/location_entity.dart';
//
// class LocationService {
//   static final LocationService _instance = LocationService._internal();
//
//   factory LocationService() => _instance;
//
//   LocationService._internal();
//
//   Future<void> init() async {
//     final granted = await requestPermission();
//     if (!granted) return;
//
//     final location = await getCurrentLocation();
//     if (location == null) return;
//   }
//
//   Future<bool> ensureLocationServiceEnabled() async {
//     final isEnabled = await Geolocator.isLocationServiceEnabled();
//
//     if (!isEnabled) {
//       return false;
//     }
//     return true;
//   }
//
//   Future<void> openLocationSetting() async {
//     await Geolocator.openLocationSettings();
//   }
//
//   Future<bool> requestPermission() async {
//     final status = await Permission.location.request();
//     if (status.isGranted) {
//       return true;
//     } else if (status.isPermanentlyDenied) {}
//     return false;
//   }
//
//   Future<LocationEntity?> getCurrentLocation() async {
//     try {
//       await requestPermission();
//       final position = await Geolocator.getCurrentPosition(
//         locationSettings: const LocationSettings(
//           accuracy: LocationAccuracy.high,
//         ),
//       );
//
//       return LocationEntity(
//         latitude: position.latitude,
//         longitude: position.longitude,
//       );
//     } catch (_) {
//       return null;
//     }
//   }
//
//   Stream<LocationEntity> get locationStream {
//     return Geolocator.getPositionStream(
//       locationSettings: const LocationSettings(
//         accuracy: LocationAccuracy.high,
//         distanceFilter: 1,
//       ),
//     ).map(
//           (pos) => LocationEntity(latitude: pos.latitude, longitude: pos.longitude),
//     );
//   }
//
//   double distanceInMeters({
//     required double lat1,
//     required double lng1,
//     required double lat2,
//     required double lng2,
//   }) {
//     return Geolocator.distanceBetween(lat1, lng1, lat2, lng2);
//   }
// }



/////////////////////////////////  *************** ///////////////


// import 'package:flutter/foundation.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../../feature/citizen/saved_location/domain/entities/location_entity/location_entity.dart';
//
// class LocationService {
//   static final LocationService _instance = LocationService._internal();
//   late LocationSettings _locationSettings;
//
//   factory LocationService() => _instance;
//
//   LocationService._internal();
//
//   Future<void> init() async {
//     // final granted = await requestPermission();
//     // if (!granted) return;
//     if (defaultTargetPlatform == TargetPlatform.android) {
//       _locationSettings = AndroidSettings(
//         accuracy: LocationAccuracy.high,
//         distanceFilter: 100,
//         forceLocationManager: true,
//         intervalDuration: const Duration(seconds: 5),
//
//         foregroundNotificationConfig: const ForegroundNotificationConfig(
//           notificationText:
//           "app will continue to receive your location even when you aren't using it",
//           notificationTitle: "Running in Background",
//           enableWakeLock: true,
//         ),
//       );
//     } else if (defaultTargetPlatform == TargetPlatform.iOS) {
//       _locationSettings = AppleSettings(
//         accuracy: LocationAccuracy.high,
//         activityType: ActivityType.automotiveNavigation,
//         distanceFilter: 100,
//         pauseLocationUpdatesAutomatically: true,
//         // Only set to true if our app will be started up in the background.
//         showBackgroundLocationIndicator: true,
//       );
//     } else {
//       _locationSettings = const LocationSettings(
//         accuracy: LocationAccuracy.high,
//         distanceFilter: 100,
//       );
//     }
//     await getCurrentLocation();
//     // if (location == null) return;
//   }
//
//   Future<bool> ensureLocationServiceEnabled() async {
//     final isEnabled = await Geolocator.isLocationServiceEnabled();
//
//     if (!isEnabled) {
//       return false;
//     }
//     return true;
//   }
//
//   Future<void> openLocationSetting() async {
//     await Geolocator.openLocationSettings();
//   }
//
//   Future<bool> requestPermission() async {
//     final status = await Permission.location.request();
//     if (status.isGranted) {
//       return true;
//     } else if (status.isPermanentlyDenied) {}
//     return false;
//   }
//
//   Future<LocationEntity?> getCurrentLocation() async {
//     try {
//       await requestPermission();
//       final position = await Geolocator.getCurrentPosition(
//         locationSettings: _locationSettings,
//       );
//
//       return LocationEntity(
//         latitude: position.latitude,
//         longitude: position.longitude,
//       );
//     } catch (_) {
//       return null;
//     }
//   }
//
//   Stream<LocationEntity> get locationStream {
//     return Geolocator.getPositionStream(
//       locationSettings: _locationSettings,
//     ).map(
//           (pos) => LocationEntity(latitude: pos.latitude, longitude: pos.longitude),
//     );
//   }
//
//   double distanceInMeters({
//     required double lat1,
//     required double lng1,
//     required double lat2,
//     required double lng2,
//   }) {
//     return Geolocator.distanceBetween(lat1, lng1, lat2, lng2);
//   }
// }
