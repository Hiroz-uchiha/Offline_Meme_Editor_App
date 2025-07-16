import 'dart:io';
import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:meme_editor_app_offline_first_flutter_application/data/models/meme_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:share_plus/share_plus.dart';

class MemeLocalDatasource {
  final Box box;
  MemeLocalDatasource(this.box);

  Future<void> saveMemes(List<MemeModel> memes) async {
    final List<Map<String, dynamic>> jsonList =
        memes.map((meme) => meme.toJson()).toList();
    await box.put('memes', jsonList);
  }

  List<MemeModel> getMemes() {
    final List cached = box.get("memes", defaultValue: []);
    return cached
        .map((e) => MemeModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<bool> saveToGallery(Uint8List imageBytes) async {
    final status = await Permission.storage.request();
    if (!status.isGranted) return false;

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

  Future<void> shareImage(Uint8List imageBytes) async {
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/shared_meme.png';
    final file = File(filePath);
    await file.writeAsBytes(imageBytes);
    await Share.shareXFiles([XFile(file.path)], text: "Check out this meme");
  }
}
