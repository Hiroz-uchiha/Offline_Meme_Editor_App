import 'package:meme_editor_app_offline_first_flutter_application/domain/repo/permission_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionRepositoryImpl implements PermissionRepository {
  @override
  Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }
}
