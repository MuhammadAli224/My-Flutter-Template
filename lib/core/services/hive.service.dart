import '../../global_imports.dart';

class HiveServices {
  Future<void> init() async {
    await Hive.initFlutter();
    // Hive.registerAdapter;

    await Future.wait([
      _initAppBox(),
    ]);
  }



  Future<void> _initAppBox() async {
    final appBox = await Hive.openBox(BoxKey.appBox);
    if (!getIt.isRegistered<Box>(instanceName: BoxKey.appBox)) {
      getIt.registerSingleton<Box>(appBox, instanceName: BoxKey.appBox);
    }
  }

  Future<void> _initializeBoxModel<T>({required String boxName}) async {
    try {
      final Box<T> box = await Hive.openBox<T>(boxName);
      if (!getIt.isRegistered<Box<T>>()) {
        getIt.registerSingleton<Box<T>>(box);
      }
    } on Exception catch (e) {
      AppLogger.e('Error while opening box $boxName : $e');
    }
  }
}
