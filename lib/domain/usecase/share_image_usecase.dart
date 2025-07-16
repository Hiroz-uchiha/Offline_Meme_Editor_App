import 'dart:typed_data';

import 'package:meme_editor_app_offline_first_flutter_application/data/repo/meme_repository_impl.dart';

class ShareImageUsecase {
  final MemeRepositoryImpl repository;

  ShareImageUsecase(this.repository);

  Future<void> call(Uint8List imageBytes) {
    return repository.shareImage(imageBytes);
  }
}
