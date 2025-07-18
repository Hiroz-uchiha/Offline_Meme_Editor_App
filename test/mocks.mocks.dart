// Mocks generated by Mockito 5.4.4 from annotations
// in meme_editor_app_offline_first_flutter_application/test/mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:typed_data' as _i9;

import 'package:meme_editor_app_offline_first_flutter_application/data/repo/meme_repository_impl.dart'
    as _i3;
import 'package:meme_editor_app_offline_first_flutter_application/domain/entities/meme.dart'
    as _i7;
import 'package:meme_editor_app_offline_first_flutter_application/domain/entities/theme_entity.dart'
    as _i12;
import 'package:meme_editor_app_offline_first_flutter_application/domain/repo/meme_repository.dart'
    as _i2;
import 'package:meme_editor_app_offline_first_flutter_application/domain/repo/theme_repository.dart'
    as _i4;
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/get_memes.dart'
    as _i5;
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/request_storage_permission.dart'
    as _i13;
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/save_image_usecase.dart'
    as _i8;
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/share_image_usecase.dart'
    as _i10;
import 'package:meme_editor_app_offline_first_flutter_application/domain/usecase/theme_usecase.dart'
    as _i11;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeMemeRepository_0 extends _i1.SmartFake
    implements _i2.MemeRepository {
  _FakeMemeRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMemeRepositoryImpl_1 extends _i1.SmartFake
    implements _i3.MemeRepositoryImpl {
  _FakeMemeRepositoryImpl_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeThemeRepository_2 extends _i1.SmartFake
    implements _i4.ThemeRepository {
  _FakeThemeRepository_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetMemes].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMemes extends _i1.Mock implements _i5.GetMemes {
  MockGetMemes() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MemeRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeMemeRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.MemeRepository);

  @override
  _i6.Future<List<_i7.MemeEntity>> call({bool? fromCache = false}) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#fromCache: fromCache},
        ),
        returnValue: _i6.Future<List<_i7.MemeEntity>>.value(<_i7.MemeEntity>[]),
      ) as _i6.Future<List<_i7.MemeEntity>>);
}

/// A class which mocks [SaveImageUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveImageUsecase extends _i1.Mock implements _i8.SaveImageUsecase {
  MockSaveImageUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.MemeRepositoryImpl get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeMemeRepositoryImpl_1(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i3.MemeRepositoryImpl);

  @override
  _i6.Future<bool> call(_i9.Uint8List? imageBytes) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [imageBytes],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);
}

/// A class which mocks [ShareImageUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockShareImageUsecase extends _i1.Mock implements _i10.ShareImageUsecase {
  MockShareImageUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.MemeRepositoryImpl get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeMemeRepositoryImpl_1(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i3.MemeRepositoryImpl);

  @override
  _i6.Future<void> call(_i9.Uint8List? imageBytes) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [imageBytes],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}

/// A class which mocks [ThemeUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockThemeUseCase extends _i1.Mock implements _i11.ThemeUseCase {
  MockThemeUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.ThemeRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeThemeRepository_2(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i4.ThemeRepository);

  @override
  _i6.Future<_i12.AppTheme> getSavedTheme() => (super.noSuchMethod(
        Invocation.method(
          #getSavedTheme,
          [],
        ),
        returnValue: _i6.Future<_i12.AppTheme>.value(_i12.AppTheme.light),
      ) as _i6.Future<_i12.AppTheme>);

  @override
  _i6.Future<void> saveTheme(_i12.AppTheme? theme) => (super.noSuchMethod(
        Invocation.method(
          #saveTheme,
          [theme],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}

/// A class which mocks [RequestStoragePermissionUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockRequestStoragePermissionUseCase extends _i1.Mock
    implements _i13.RequestStoragePermissionUseCase {
  MockRequestStoragePermissionUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<bool> call() => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);
}
