import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:meme_editor_app_offline_first_flutter_application/data/datasources/meme_local_datasource.dart';
import 'package:meme_editor_app_offline_first_flutter_application/data/datasources/meme_remote_datasources.dart';
import 'package:meme_editor_app_offline_first_flutter_application/data/repo/meme_repository_impl.dart';
import 'package:meme_editor_app_offline_first_flutter_application/data/repo/theme_repository_impl.dart';
import 'package:meme_editor_app_offline_first_flutter_application/data/repo/permission_repository_impl.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/repo/permission_repository.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/get_memes.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/request_storage_permission.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/save_image_usecase.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/share_image_usecase.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/theme_usecase.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/repo/theme_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppDependencies {
  final GetMemes getMemes;
  final SaveImageUsecase saveImage;
  final ShareImageUsecase shareImage;
  final ThemeUseCase themeUseCase;
  final RequestStoragePermissionUseCase requestStoragePermission;

  AppDependencies({
    required this.getMemes,
    required this.saveImage,
    required this.shareImage,
    required this.themeUseCase,
    required this.requestStoragePermission,
  });
}

Future<AppDependencies> initDependencies() async {
  final memeBox = await Hive.openBox('memes');
  final settingsBox = await Hive.openBox('settings');

  final dio = Dio();
  final remote = MemeRemoteDatasources(dio);
  final local = MemeLocalDatasource(memeBox);
  final repository = MemeRepositoryImpl(remote, local);

  final ThemeRepository themeRepository = ThemeRepositoryImpl(settingsBox);
  final ThemeUseCase themeUseCase = ThemeUseCase(themeRepository);

  // Permission repository dan usecase
  final PermissionRepository permissionRepository = PermissionRepositoryImpl();
  final requestStoragePermission = RequestStoragePermissionUseCase();

  return AppDependencies(
    getMemes: GetMemes(repository),
    saveImage: SaveImageUsecase(repository),
    shareImage: ShareImageUsecase(repository),
    themeUseCase: themeUseCase,
    requestStoragePermission: requestStoragePermission,
  );
}
