import 'dart:io';

import 'package:flutter/material.dart';
import '../editor_item.dart';
import 'drag_item.dart';

class MemeCanvas extends StatelessWidget {
  final String imageUrl;
  final bool isOffline;
  final List<EditorItem> items;
  final GlobalKey containerKey;
  final Function(int index)? onTextTap;

  const MemeCanvas({
    super.key,
    required this.imageUrl,
    required this.isOffline,
    required this.items,
    required this.containerKey,
    this.onTextTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          key: containerKey,
          height: 500,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: isOffline
                      ? Image.file(
                          File(imageUrl),
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Center(child: Icon(Icons.broken_image)),
                        )
                      : Image.network(
                          imageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                          errorBuilder: (_, __, ___) =>
                              const Center(child: Icon(Icons.broken_image)),
                        ),
                ),
              ),
              ...items.asMap().entries.map(
                    (entry) => DragItem(
                      item: entry.value,
                      index: entry.key,
                      parentKey: containerKey,
                      onTextTap: onTextTap,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
