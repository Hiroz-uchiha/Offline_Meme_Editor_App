import 'package:dio/dio.dart';
import 'package:meme_editor_app_offline_first_flutter_application/data/models/meme_model.dart';

class MemeRemoteDatasources {
  final Dio dio;
  MemeRemoteDatasources(this.dio);

  Future<List<MemeModel>> getMemes() async {
    try {
      final response = await dio.get("https://api.imgflip.com/get_memes");
      final data = response.data['data']['memes'] as List;

      return data.map((json) => MemeModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
}
