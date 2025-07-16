import 'dart:typed_data';

import 'package:meme_editor_app_offline_first_flutter_application/data/datasources/meme_local_datasource.dart';
import 'package:meme_editor_app_offline_first_flutter_application/data/datasources/meme_remote_datasources.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/entities/meme.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/repo/meme_repository.dart';

class MemeRepositoryImpl implements MemeRepository {
  final MemeRemoteDatasources remote;
  final MemeLocalDatasource local;

  MemeRepositoryImpl(this.remote, this.local);

  @override
  Future<List<MemeEntity>> getMemes({bool fromCache = false}) async {
    if (fromCache) {
      final memes = local.getMemes();
      print("CACHE LENGTH : ${memes.length}");
      return memes;
    } else {
      final memes = await remote.getMemes();
      memes.shuffle();
      await local.saveMemes(memes);
      return memes;
    }
  }

  @override
  Future<bool> saveImageToGallery(Uint8List imageBytes) {
    return local.saveToGallery(imageBytes);
  }

  @override
  Future<void> shareImage(Uint8List imageBytes) {
    return local.shareImage(imageBytes);
  }
}
