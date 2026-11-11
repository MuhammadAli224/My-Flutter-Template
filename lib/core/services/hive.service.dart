import '../../global_imports.dart';

class HiveServices {
  Future<void> init() async {
    await Hive.initFlutter();
    await Future.wait([_openBox(BoxKey.appBox), _openBox(BoxKey.cacheBox)]);
  }

  Future<void> _openBox(String name) async {
    final box = await Hive.openBox<dynamic>(name);
    if (!getIt.isRegistered<Box>(instanceName: name)) {
      getIt.registerSingleton<Box>(
        box,
        instanceName: name,
        dispose: (value) => value.close(),
      );
    }
  }
}
