import 'package:flutter/material.dart';

class EditorItem {
  final String type;
  final String content;
  final Offset position;

  EditorItem(
      {required this.type, required this.content, required this.position});

  EditorItem copyWith({Offset? position, String? content}) {
    return EditorItem(
        type: type,
        content: content ?? this.content,
        position: position ?? this.position);
  }
}
