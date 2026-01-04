import '../../../../global_imports.dart';
import '../../feature/splash_screen/splash_screen.dart';

GoRouter goRouters = GoRouter(
  navigatorKey: GlobalContext.navigatorKey,
  debugLogDiagnostics: true,
  initialLocation: AppRoutes.root,
  routes: [
    GoRoute(path: AppRoutes.root, builder: (_, __) => const SplashScreen()),
  ],
);
