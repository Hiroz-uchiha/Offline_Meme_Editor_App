import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/save_image_usecase.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/share_image_usecase.dart';

class ExportController extends ChangeNotifier {
  final SaveImageUsecase saveImage;
  final ShareImageUsecase shareImage;

  ExportController({
    required this.saveImage,
    required this.shareImage,
  });

  Future<void> exportToGallery(
      Uint8List imageBytes, BuildContext context) async {
    try {
      final success = await saveImage(imageBytes);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(success ? 'Gambar disimpan!' : 'Gagal menyimpan')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission ditolak atau gagal simpan')),
      );
    }
  }

  Future<void> shareImageToApp(Uint8List imageBytes) async {
    await shareImage(imageBytes);
  }
}
