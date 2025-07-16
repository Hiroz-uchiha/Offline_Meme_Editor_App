import 'package:meme_editor_app_offline_first_flutter_application/domain/entities/meme.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/repo/meme_repository.dart';

class GetMemes {
  final MemeRepository repository;

  GetMemes(this.repository);

  Future<List<MemeEntity>> call({bool fromCache = false}) {
    return repository.getMemes(fromCache: fromCache);
  }
}
