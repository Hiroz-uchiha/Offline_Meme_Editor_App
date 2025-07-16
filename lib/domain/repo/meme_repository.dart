import 'dart:typed_data';

import 'package:meme_editor_app_offline_first_flutter_application/domain/entities/meme.dart';

abstract class MemeRepository {
  Future<List<MemeEntity>> getMemes({bool fromCache = false});

  Future<bool> saveImageToGallery(Uint8List imageBytes);
  Future<void> shareImage(Uint8List imageBytes);
}
