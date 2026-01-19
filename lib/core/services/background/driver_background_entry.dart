// import 'dart:async';
// import 'dart:developer';
// import 'dart:ui';
//
// import 'package:flutter_background_service/flutter_background_service.dart';
//
// import '../../../feature/citizen/saved_location/domain/entities/location_entity/location_entity.dart';
// import '../../dependencies/dependencies_injection.dart';
// import '../location.service.dart';
// import '../signalR.service.dart';
//
// @pragma('vm:entry-point')
// void driverBackgroundEntry(ServiceInstance service) async {
//   DartPluginRegistrant.ensureInitialized();
//   await configureDependencies();
//
//   final signalRService = getIt<SignalRService>();
//
//   StreamSubscription<LocationEntity>? locationSubscription;
//   LocationEntity? lastLocation;
//
//   if (service is AndroidServiceInstance) {
//     await service.setAsForegroundService();
//     await service.setForegroundNotificationInfo(
//       title: 'Driver active',
//       content: 'Location is being tracked',
//     );
//     // await service.setAsBackgroundService();
//   }
//
//   // ✅ LISTEN for START command
//   service.on('startTracking').listen((event) async {
//     final driverId = event?['driverId'] as String?;
//
//     if (driverId == null) return;
//     if (!signalRService.isConnectedLocation) {
//       await signalRService.connectLocation(orderId: driverId);
//     }
//     await locationSubscription?.cancel();
//
//     locationSubscription = getIt<LocationService>().locationStream.listen((
//       location,
//     ) async {
//       if (lastLocation != null) {
//         final distance = getIt<LocationService>().distanceInMeters(
//           lat1: lastLocation!.latitude,
//           lng1: lastLocation!.longitude,
//           lat2: location.latitude,
//           lng2: location.longitude,
//         );
//         if (distance < 15) return;
//       }
//
//       lastLocation = location;
//
//       await signalRService.sendToGroup(
//         driverId,
//         'latitude: ${lastLocation!.latitude}, longitude: ${lastLocation!.longitude}',
//       );
//       log(
//         '📍 Location sent: ${lastLocation!.latitude}, ${lastLocation!.longitude}',
//       );
//     });
//   });
//
//   // ✅ LISTEN for STOP command
//   service.on('stop').listen((_) async {
//     await locationSubscription?.cancel();
//     await signalRService.disconnectLocation();
//     service.stopSelf();
//   });
// }
