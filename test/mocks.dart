import 'package:mockito/annotations.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/get_memes.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/save_image_usecase.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/share_image_usecase.dart';

@GenerateMocks([
  GetMemes,
  SaveImageUsecase,
  ShareImageUsecase,
])
void main() {}
