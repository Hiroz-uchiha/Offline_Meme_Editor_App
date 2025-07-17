import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:meme_editor_app_offline_first_flutter_application/data/models/meme_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:share_plus/share_plus.dart';

class MemeLocalDatasource {
  final Box box;
  final Dio dio = Dio();

  MemeLocalDatasource(this.box);

  // Simpan file gambar dan metadata ke Hive
  Future<void> saveMemes(List<MemeModel> memes) async {
    final dir = await getApplicationDocumentsDirectory();
    final savedMemes = <Map<String, dynamic>>[];

    for (final meme in memes) {
      try {
        final response = await dio.get<List<int>>(
          meme.url,
          options: Options(responseType: ResponseType.bytes),
        );

        final fileName = '${meme.id}.jpg';
        final filePath = '${dir.path}/$fileName';

        final file = File(filePath);
        await file.writeAsBytes(response.data!);

        final memeJson = meme.toJson();
        memeJson['url'] = filePath;

        savedMemes.add(memeJson);
      } catch (e) {
        print("Gagal download gambar: ${meme.url}, error: $e");
      }
    }

    await box.put('memes', savedMemes);
  }

  // Mengambil data meme lokal
  List<MemeModel> getMemes() {
    final List cached = box.get("memes", defaultValue: []);
    return cached
        .map((e) => MemeModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  // Simpan ke Galeri
  Future<bool> saveToGallery(Uint8List imageBytes) async {
    final photosStatus = await Permission.photos.request();
    final storageStatus = await Permission.storage.request();

    if (!photosStatus.isGranted && !storageStatus.isGranted) {
      print("Permission denied");
      return false;
    }

    try {
      final fileName =
          "edited_meme_${DateTime.now().millisecondsSinceEpoch}.png";

      final result = await SaverGallery.saveImage(
        imageBytes,
        fileName: fileName,
        skipIfExists: false,
      );

      if (result.isSuccess) {
        print("Image saved successfully!");
      } else {
        print("Failed to save image: ${result.errorMessage}");
      }

      return result.isSuccess;
    } catch (e) {
      print("Exception saving image: $e");
      return false;
    }
  }

  // Share gambar
  Future<void> shareImage(Uint8List imageBytes) async {
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/shared_meme.png';
    final file = File(filePath);
    await file.writeAsBytes(imageBytes);
    await Share.shareXFiles([XFile(file.path)], text: "Check out this meme");
  }
}
