import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/di/injection.dart';
import 'widgets/export_controller.dart';

class ExportPage extends StatelessWidget {
  final Uint8List imageBytes;
  final AppDependencies appDependencies;

  const ExportPage({
    Key? key,
    required this.imageBytes,
    required this.appDependencies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExportController>(
      create: (_) => ExportController(
        saveImage: appDependencies.saveImage,
        shareImage: appDependencies.shareImage,
        requestPermission: appDependencies.requestStoragePermission,
      ),
      child: Consumer<ExportController>(
        builder: (context, controller, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Export Meme"),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Image.memory(
                      imageBytes,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.save_alt),
                      label: const Text("Simpan"),
                      onPressed: () async {
                        await controller.exportToGallery(imageBytes, context);
                      },
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.share),
                      label: const Text("Bagikan"),
                      onPressed: () async {
                        await controller.shareImageToApp(imageBytes);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
