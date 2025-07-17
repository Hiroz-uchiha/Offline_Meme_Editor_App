import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/request_storage_permission.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/save_image_usecase.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/share_image_usecase.dart';

class ExportController extends ChangeNotifier {
  final SaveImageUsecase saveImage;
  final ShareImageUsecase shareImage;
  final RequestStoragePermissionUseCase requestPermission;

  ExportController({
    required this.saveImage,
    required this.shareImage,
    required this.requestPermission,
  });

  Future<void> exportToGallery(
      Uint8List imageBytes, BuildContext context) async {
    try {
      // Request permission storage
      final permissionGranted = await requestPermission();
      if (!permissionGranted) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permission storage ditolak')),
        );
        return;
      }

      // Simpan gambar
      final success = await saveImage(imageBytes);

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              success ? 'Gambar berhasil disimpan!' : 'Gagal menyimpan gambar'),
        ),
      );
    } catch (e) {
      print('exportToGallery error: $e');
    }
  }

  Future<void> shareImageToApp(Uint8List imageBytes) async {
    try {
      await shareImage(imageBytes);
    } catch (e) {
      print(e);
    }
  }
}
