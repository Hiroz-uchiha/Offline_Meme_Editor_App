import 'package:permission_handler/permission_handler.dart';

class RequestStoragePermissionUseCase {
  Future<bool> call() async {
    // Cek jika sudah diberikan
    if (await Permission.photos.isGranted ||
        await Permission.storage.isGranted) {
      return true;
    }

    // Minta izin
    final result = await [
      Permission.photos,
      Permission.storage,
    ].request();

    return result[Permission.photos]?.isGranted == true ||
        result[Permission.storage]?.isGranted == true;
  }
}
