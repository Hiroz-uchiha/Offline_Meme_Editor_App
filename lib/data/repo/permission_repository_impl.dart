import 'package:permission_handler/permission_handler.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/repo/permission_repository.dart';
import '../utils/device_utils.dart';

class PermissionRepositoryImpl implements PermissionRepository {
  @override
  Future<bool> requestStoragePermission() async {
    final sdkInt = await DeviceUtils.getAndroidSdkVersion();

    if (sdkInt >= 33) {
      final status = await Permission.photos.request();
      return status.isGranted;
    } else {
      final status = await Permission.storage.request();
      return status.isGranted;
    }
  }
}
