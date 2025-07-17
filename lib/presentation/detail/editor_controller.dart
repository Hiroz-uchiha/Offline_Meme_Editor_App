import 'package:flutter/material.dart';
import 'editor_item.dart';

class EditorController extends ChangeNotifier {
  final List<EditorItem> _items = [];
  final List<List<EditorItem>> _undoStack = [];
  final List<List<EditorItem>> _redoStack = [];

  List<EditorItem> get items => List.unmodifiable(_items);

  void _saveState() {
    _undoStack.add(_items
        .map((e) => e.copyWith(position: e.position, content: e.content))
        .toList());
    _redoStack.clear();
  }

  void addItem(EditorItem item) {
    _saveState();
    _items.add(item);
    notifyListeners();
  }

  void updateItemPosition(int index, Offset newPos) {
    _saveState();
    _items[index] = _items[index].copyWith(position: newPos);
    notifyListeners();
  }

  void updateItemContent(int index, String newContent) {
    _saveState();
    final oldItem = _items[index];
    _items[index] = EditorItem(
      type: oldItem.type,
      content: newContent,
      position: oldItem.position,
    );
    notifyListeners();
  }

  void undo() {
    if (_undoStack.isNotEmpty) {
      _redoStack.add(_items
          .map((e) => e.copyWith(position: e.position, content: e.content))
          .toList());
      _items
        ..clear()
        ..addAll(_undoStack.removeLast());
      notifyListeners();
    }
  }

  void redo() {
    if (_redoStack.isNotEmpty) {
      _undoStack.add(_items
          .map((e) => e.copyWith(position: e.position, content: e.content))
          .toList());
      _items
        ..clear()
        ..addAll(_redoStack.removeLast());
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    _undoStack.clear();
    _redoStack.clear();
    notifyListeners();
  }
}
