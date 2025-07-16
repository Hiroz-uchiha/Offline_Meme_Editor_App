import 'package:flutter/material.dart';
import '../editor_item.dart';
import 'drag_item.dart';

class MemeCanvas extends StatelessWidget {
  final String imageUrl;
  final List<EditorItem> items;
  final GlobalKey containerKey;
  final Function(int index)? onTextTap;

  const MemeCanvas({
    super.key,
    required this.imageUrl,
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
          height: 1000,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
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
