import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:meme_editor_app_offline_first_flutter_application/data/datasources/meme_local_datasource.dart';
import 'package:meme_editor_app_offline_first_flutter_application/data/datasources/meme_remote_datasources.dart';
import 'package:meme_editor_app_offline_first_flutter_application/data/repo/meme_repository_impl.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/get_memes.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/save_image_usecase.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/share_image_usecase.dart';

class AppDependencies {
  final GetMemes getMemes;
  final SaveImageUsecase saveImage;
  final ShareImageUsecase shareImage;

  AppDependencies({
    required this.getMemes,
    required this.saveImage,
    required this.shareImage,
  });
}

Future<AppDependencies> initDependencies() async {
  final box = await Hive.openBox('memes');
  final dio = Dio();
  final remote = MemeRemoteDatasources(dio);
  final local = MemeLocalDatasource(box);
  final repository = MemeRepositoryImpl(remote, local);

  return AppDependencies(
    getMemes: GetMemes(repository),
    saveImage: SaveImageUsecase(repository),
    shareImage: ShareImageUsecase(repository),
  );
}
