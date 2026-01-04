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
//
//   LocationService._internal();
//
//
//   Future<void> init() async {
//     final granted = await requestPermission();
//     if (!granted) return;
//
//     final location = await getCurrentLocation();
//     if (location == null) return;
//
//
//   }
//
//   Future<bool> requestPermission() async {
//     final status = await Permission.location.request();
//     if (status.isGranted) {
//       return true;
//     } else if (status.isPermanentlyDenied) {
//       // await openAppSettings();
//     }
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
//           (pos) =>
//           LocationEntity(latitude: pos.latitude, longitude: pos.longitude),
//     );
//   }
//
//
// }
