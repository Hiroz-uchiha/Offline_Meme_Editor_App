import 'package:meme_editor_app_offline_first_flutter_application/domain/entities/theme_entity.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/repo/theme_repository.dart';

class ThemeUseCase {
  final ThemeRepository repository;

  ThemeUseCase(this.repository);

  Future<AppTheme> getSavedTheme() => repository.getSavedTheme();

  Future<void> saveTheme(AppTheme theme) => repository.saveTheme(theme);
}
