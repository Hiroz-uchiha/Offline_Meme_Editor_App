import 'dart:typed_data';

abstract class GalleryRepository {
  Future<bool> saveImage(Uint8List imageBytes);
  Future<void> shareImage(Uint8List imageBytes);
}
