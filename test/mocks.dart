import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/request_storage_permission.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/theme_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/get_memes.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/save_image_usecase.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/share_image_usecase.dart';

@GenerateMocks([
  GetMemes,
  SaveImageUsecase,
  ShareImageUsecase,
  ThemeUseCase,
  RequestStoragePermissionUseCase,
])
void main() {}
