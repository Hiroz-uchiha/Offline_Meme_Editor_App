import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:meme_editor_app_offline_first_flutter_application/presentation/export/widgets/export_controller.dart';
import 'package:provider/provider.dart';

class ExportPage extends StatelessWidget {
  final Uint8List imageBytes;

  const ExportPage({super.key, required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ExportController>(context, listen: false);

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
  }
}
