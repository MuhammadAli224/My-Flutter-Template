import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConstant {
  EnvConstant._();

  static Future<void> init() async {
    await dotenv.load(fileName: '.env');
  }

  static String get server => dotenv.env['SERVER'] ?? "";

  // static String get moyasarPublishKeyTest =>
  //     dotenv.env['MOYASAR_PUBLISHED_KEY_TEST'] ?? "";
  //
  // static String get moyasarSecretKeyTest =>
  //     dotenv.env['MOYASAR_SECRET_KEY_TEST'] ?? "";
}
