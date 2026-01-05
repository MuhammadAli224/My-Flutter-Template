import '../../global_imports.dart';

class AppGradient {
  AppGradient._();

  static const LinearGradient green = LinearGradient(
    colors: [Color(0xFF018355), Color(0xFF00B071)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient greenWhite = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF), Color(0xFF00B071)],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
  );
}
