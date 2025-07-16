import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meme_editor_app_offline_first_flutter_application/core/di/injection.dart';
import 'package:meme_editor_app_offline_first_flutter_application/presentation/common/themeprov.dart';
import 'package:meme_editor_app_offline_first_flutter_application/presentation/detail/editor_controller.dart';
import 'package:meme_editor_app_offline_first_flutter_application/presentation/export/widgets/export_controller.dart';
import 'package:meme_editor_app_offline_first_flutter_application/presentation/home/home_page.dart';
import 'package:meme_editor_app_offline_first_flutter_application/presentation/home/home_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final usecase = await initDependencies();
  runApp(MyApp(usecase));
}

class MyApp extends StatelessWidget {
  final AppDependencies usecase;
  const MyApp(this.usecase, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeProvider(usecase.getMemes)..loadMemes(),
        ),
        ChangeNotifierProvider(
          create: (_) => ExportController(
            saveImage: usecase.saveImage,
            shareImage: usecase.shareImage,
            requestPermission: usecase.requestStoragePermission,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => EditorController(),
        ),
        ChangeNotifierProvider(
            create: (_) => ThemeProvider(usecase.themeUseCase)..loadTheme()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProv, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blueGrey,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            themeMode: themeProv.themeMode,
            home: HomePage(
                appDependencies: usecase), // <-- kirim usecase ke HomePage
          );
        },
      ),
    );
  }
}
