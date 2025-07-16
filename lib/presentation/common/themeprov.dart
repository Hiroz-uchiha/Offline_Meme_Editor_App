import 'package:flutter/material.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/theme_usecase.dart';
import '../../domain/entities/theme_entity.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemeUseCase _themeUseCase;

  AppTheme _currentTheme = AppTheme.light;
  bool _isInitialized = false;

  ThemeProvider(this._themeUseCase);

  AppTheme get currentTheme => _currentTheme;

  ThemeMode get themeMode =>
      _currentTheme == AppTheme.dark ? ThemeMode.dark : ThemeMode.light;

  bool get isInitialized => _isInitialized;

  Future<void> loadTheme() async {
    _currentTheme = await _themeUseCase.getSavedTheme();
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> toggleTheme(bool isDark) async {
    _currentTheme = isDark ? AppTheme.dark : AppTheme.light;
    await _themeUseCase.saveTheme(_currentTheme);
    notifyListeners();
  }
}
