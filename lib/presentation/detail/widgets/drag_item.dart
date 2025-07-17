import 'package:flutter/material.dart';
import '../editor_item.dart';
import '../editor_controller.dart';
import 'package:provider/provider.dart';

class DragItem extends StatelessWidget {
  final EditorItem item;
  final int index;
  final GlobalKey parentKey;
  final Function(int index)? onTextTap;

  const DragItem({
    super.key,
    required this.item,
    required this.index,
    required this.parentKey,
    this.onTextTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: item.position.dx,
      top: item.position.dy,
      child: GestureDetector(
        onTap: () {
          if (item.type == 'text') {
            onTextTap?.call(index);
          }
        },
        child: Draggable(
          feedback: Material(
            color: Colors.transparent,
            child: _buildContent(),
          ),
          childWhenDragging: Opacity(
            opacity: 0.5,
            child: _buildContent(),
          ),
          onDragEnd: (details) {
            final RenderBox box =
                parentKey.currentContext?.findRenderObject() as RenderBox;
            final Offset localOffset = box.globalToLocal(details.offset);

            Provider.of<EditorController>(context, listen: false)
                .updateItemPosition(index, localOffset);
          },
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (item.type == 'text') {
      return Text(
        item.content,
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
          backgroundColor: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (item.type == 'sticker') {
      return Text(
        item.content,
        style: const TextStyle(fontSize: 50),
      );
    } else if (item.type == 'image') {
      return Image.network(
        item.content,
        width: 50,
        height: 50,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
