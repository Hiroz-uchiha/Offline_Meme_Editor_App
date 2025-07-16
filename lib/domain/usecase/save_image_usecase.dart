import 'dart:typed_data';

import 'package:meme_editor_app_offline_first_flutter_application/data/repo/meme_repository_impl.dart';

class SaveImageUsecase {
  final MemeRepositoryImpl repository;

  SaveImageUsecase(this.repository);

  Future<bool> call(Uint8List imageBytes) {
    return repository.saveImageToGallery(imageBytes);
  }
}
