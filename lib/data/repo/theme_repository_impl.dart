import 'package:hive/hive.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/entities/theme_entity.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/repo/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  static const _keyTheme = 'app_theme';

  final Box _box;

  ThemeRepositoryImpl(this._box);

  @override
  Future<AppTheme> getSavedTheme() async {
    final stored = _box.get(_keyTheme, defaultValue: 'light') as String;
    return stored == 'dark' ? AppTheme.dark : AppTheme.light;
  }

  @override
  Future<void> saveTheme(AppTheme theme) async {
    await _box.put(_keyTheme, theme == AppTheme.dark ? 'dark' : 'light');
  }
}
