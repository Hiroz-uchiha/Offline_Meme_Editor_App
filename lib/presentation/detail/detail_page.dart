import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meme_editor_app_offline_first_flutter_application/presentation/export/export_page.dart';
import 'package:provider/provider.dart';
import '../../core/di/injection.dart';
import 'editor_controller.dart';
import 'editor_item.dart';
import 'widgets/meme_canvas.dart';

class DetailPage extends StatefulWidget {
  final String imageUrl;
  final bool isOffline;
  final AppDependencies appDependencies;
  final String name;
  final int captions;

  const DetailPage({
    super.key,
    required this.imageUrl,
    required this.isOffline,
    required this.appDependencies,
    required this.name,
    required this.captions,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final GlobalKey repaintKey = GlobalKey();
  final GlobalKey canvasKey = GlobalKey();
  bool isFabOpen = false;

  Future<Uint8List?> captureImage() async {
    final boundary =
        repaintKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return null;
    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  Future<void> _showAddTextDialog(
      {String initialText = '', int? editIndex}) async {
    final prov = Provider.of<EditorController>(context, listen: false);
    final TextEditingController controller =
        TextEditingController(text: initialText);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(editIndex == null ? 'Add Text' : 'Edit Text'),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLines: null,
          decoration: const InputDecoration(hintText: 'Enter your text'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                if (editIndex == null) {
                  final newItem = EditorItem(
                    type: 'text',
                    content: text,
                    position: const Offset(100, 100),
                  );
                  prov.addItem(newItem);
                } else {
                  prov.updateItemContent(editIndex, text);
                }
                Navigator.of(context).pop();
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<EditorController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Meme"),
        actions: [
          IconButton(onPressed: prov.undo, icon: const Icon(Icons.undo)),
          IconButton(onPressed: prov.redo, icon: const Icon(Icons.redo)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              RepaintBoundary(
                key: repaintKey,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: MemeCanvas(
                    imageUrl: widget.imageUrl,
                    isOffline: widget.isOffline,
                    items: prov.items,
                    containerKey: canvasKey,
                    onTextTap: (index) {
                      _showAddTextDialog(
                        initialText: prov.items[index].content,
                        editIndex: index,
                      );
                    },
                    name: widget.name,
                    captions: widget.captions,
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.upload),
                  label: const Text("Export"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () async {
                    final imageBytes = await captureImage();
                    if (imageBytes != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ExportPage(
                            imageBytes: imageBytes,
                            appDependencies: widget.appDependencies,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Gagal menangkap gambar")),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, right: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (isFabOpen) ...[
              FloatingActionButton.extended(
                heroTag: 'add_text',
                onPressed: () {
                  _showAddTextDialog();
                  setState(() => isFabOpen = false);
                },
                label: const Text("Add Text"),
                icon: const Icon(Icons.text_fields),
              ),
              const SizedBox(height: 12),
              FloatingActionButton.extended(
                heroTag: 'add_sticker',
                onPressed: () {
                  final newItem = EditorItem(
                    type: 'sticker',
                    content: '😎',
                    position: const Offset(100, 100),
                  );
                  prov.addItem(newItem);
                  setState(() => isFabOpen = false);
                },
                label: const Text("Add Sticker"),
                icon: const Icon(Icons.emoji_emotions),
              ),
              const SizedBox(height: 12),
            ],
            FloatingActionButton(
              heroTag: 'toggle_fab',
              onPressed: () => setState(() => isFabOpen = !isFabOpen),
              child: Icon(isFabOpen ? Icons.close : Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
