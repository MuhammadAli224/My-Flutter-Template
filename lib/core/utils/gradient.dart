import '../../global_imports.dart';

class AppGradient {
  AppGradient._();

  static const LinearGradient green = LinearGradient(
    colors: [AppColor.secondaryColor600, AppColor.secondaryColor],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient greenWhite = LinearGradient(
    colors: [AppColor.white, AppColor.white, AppColor.secondaryColor],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
  );
}
