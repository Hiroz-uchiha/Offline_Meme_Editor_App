// domain/usecases/request_storage_permission.dart
import 'package:permission_handler/permission_handler.dart';

class RequestStoragePermissionUseCase {
  Future<bool> call() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }
}
