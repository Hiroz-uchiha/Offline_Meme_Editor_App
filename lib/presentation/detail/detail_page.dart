import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'editor_controller.dart';
import 'editor_item.dart';
import 'widgets/meme_canvas.dart';

class DetailPage extends StatefulWidget {
  final String imageUrl;
  const DetailPage({super.key, required this.imageUrl});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final GlobalKey repaintKey = GlobalKey();
  final GlobalKey canvasKey = GlobalKey(); // key untuk container canvas
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
          decoration: const InputDecoration(
            hintText: 'Enter your text',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
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
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: RepaintBoundary(
              key: repaintKey,
              child: Align(
                alignment: Alignment.topCenter,
                child: MemeCanvas(
                  imageUrl: widget.imageUrl,
                  items: prov.items,
                  containerKey: canvasKey,
                  onTextTap: (index) {
                    // kalau teks di canvas di tap, edit teks
                    _showAddTextDialog(
                      initialText: prov.items[index].content,
                      editIndex: index,
                    );
                  },
                ),
              ),
            ),
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
                  setState(() {
                    isFabOpen = false;
                  });
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
                  setState(() {
                    isFabOpen = false;
                  });
                },
                label: const Text("Add Sticker"),
                icon: const Icon(Icons.emoji_emotions),
              ),
              const SizedBox(height: 12),
            ],
            FloatingActionButton(
              heroTag: 'toggle_fab',
              onPressed: () {
                setState(() {
                  isFabOpen = !isFabOpen;
                });
              },
              child: Icon(isFabOpen ? Icons.close : Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
