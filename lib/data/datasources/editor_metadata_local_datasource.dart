import 'package:hive/hive.dart';
import 'package:meme_editor_app_offline_first_flutter_application/data/models/editor_item_hive.dart';
import 'package:meme_editor_app_offline_first_flutter_application/presentation/detail/editor_item.dart';

class EditorMetadataLocalDatasource {
  final Box box;

  EditorMetadataLocalDatasource(this.box);

  Future<void> save(String memeId, List<EditorItem> items) async {
    final data = items.map((e) => EditorItemHive.fromEditorItem(e)).toList();
    await box.put(memeId, data);
  }

  List<EditorItem> load(String memeId) {
    final List<dynamic>? raw = box.get(memeId);
    if (raw == null) return [];
    return raw.cast<EditorItemHive>().map((e) => e.toEditorItem()).toList();
  }

  Future<void> clear(String memeId) async {
    await box.delete(memeId);
  }
}
