import 'package:meme_editor_app_offline_first_flutter_application/domain/entities/theme_entity.dart';

abstract class ThemeRepository {
  Future<AppTheme> getSavedTheme();
  Future<void> saveTheme(AppTheme theme);
}
