// import 'dart:developer';
//
// import 'package:flutter_background_service/flutter_background_service.dart';
//
// import 'driver_background_entry.dart';
//
// class DriverBackgroundService {
//   static Future<void> start({required String driverId}) async {
//     final service = FlutterBackgroundService();
//
//     final isRunning = await service.isRunning();
//     if (!isRunning) {
//       await service.configure(
//         androidConfiguration: AndroidConfiguration(
//           onStart: driverBackgroundEntry,
//           autoStart: true,
//           isForegroundMode: true,
//         ),
//         iosConfiguration: IosConfiguration(
//           onForeground: driverBackgroundEntry,
//           onBackground: (_) async => true,
//         ),
//       );
//       log('Background tracking started for driver: $driverId');
//
//       await service.startService();
//     }
//
//     // ✅ SEND DATA AFTER START
//     service.invoke('startTracking', {'driverId': driverId});
//   }
//
//   static Future<void> stop() async {
//     FlutterBackgroundService().invoke('stop');
//   }
// }
