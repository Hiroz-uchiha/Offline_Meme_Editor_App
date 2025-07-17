import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:meme_editor_app_offline_first_flutter_application/domain/entities/meme.dart';
import 'package:meme_editor_app_offline_first_flutter_application/core/di/injection.dart';
import 'package:meme_editor_app_offline_first_flutter_application/main.dart';
import 'package:meme_editor_app_offline_first_flutter_application/presentation/home/home_page.dart';

import 'mocks.mocks.dart';

void main() {
  testWidgets('App shows home page without crashing',
      (WidgetTester tester) async {
    final mockGetMemes = MockGetMemes();
    final mockSaveImage = MockSaveImageUsecase();
    final mockShareImage = MockShareImageUsecase();
    final mockThemeUseCase = MockThemeUseCase();
    final mockPermissionUseCase = MockRequestStoragePermissionUseCase();

    when(mockGetMemes.call()).thenAnswer((_) async => [
          MemeEntity(
            id: '1',
            name: 'Meme Lucu',
            url: 'https://example.com/meme.jpg',
            width: 500,
            height: 500,
            box_count: 2,
            captions: 0,
          )
        ]);

    final mockDeps = AppDependencies(
      getMemes: mockGetMemes,
      saveImage: mockSaveImage,
      shareImage: mockShareImage,
      themeUseCase: mockThemeUseCase,
      requestStoragePermission: mockPermissionUseCase,
    );

    await tester.pumpWidget(MyApp(mockDeps));
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);
  });
}
