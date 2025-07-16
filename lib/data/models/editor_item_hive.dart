import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meme_editor_app_offline_first_flutter_application/presentation/detail/editor_item.dart';

@HiveType(typeId: 1)
class EditorItemHive {
  @HiveField(0)
  final String type;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final double dx;

  @HiveField(3)
  final double dy;

  EditorItemHive(this.type, this.content, this.dx, this.dy);

  factory EditorItemHive.fromEditorItem(EditorItem item) {
    return EditorItemHive(
        item.type, item.content, item.position.dx, item.position.dy);
  }

  EditorItem toEditorItem() {
    return EditorItem(type: type, content: content, position: Offset(dx, dy));
  }
}
