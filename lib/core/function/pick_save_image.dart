import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

Future<String?> saveImageLocally(String imagePath) async {
  final appDir = await getApplicationDocumentsDirectory();
  final ext = path.extension(imagePath);
  final newFileName = '${DateTime.now().microsecondsSinceEpoch}$ext';
  final newPath = path.join(appDir.path, newFileName);
  final file = File(imagePath);
  final savedFile = await file.copy(newPath);
  return savedFile.path;
}

Future<void> deleteImage(String? imagePath) async {
  if (imagePath != null) {
    final file = File(imagePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
