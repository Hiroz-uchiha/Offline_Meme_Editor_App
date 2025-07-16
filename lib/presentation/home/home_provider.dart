import 'package:flutter/material.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/entities/meme.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/get_memes.dart';

class HomeProvider with ChangeNotifier {
  final GetMemes getMemes;

  HomeProvider(this.getMemes);

  List<MemeEntity> _memes = [];
  List<MemeEntity> _filtered = [];
  bool _loading = false;
  bool _offlineMode = false;

  List<MemeEntity> get memes => _filtered;
  bool get isLoading => _loading;
  bool get isOffline => _offlineMode;

  Future<void> loadMemes() async {
    _loading = true;
    notifyListeners();

    final result = await getMemes(fromCache: _offlineMode);
    print("LOAD MEMES: fromCache=$_offlineMode, result=${result.length}");
    _memes = result;
    _filtered = result;
    _loading = false;
    notifyListeners();
  }

  void toggleOffline(bool value) {
    _offlineMode = value;
    loadMemes();
  }

  void searchMemes(String keyword) {
    _filtered = _memes
        .where((e) => e.name.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
