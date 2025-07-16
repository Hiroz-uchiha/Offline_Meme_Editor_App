import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meme_editor_app_offline_first_flutter_application/core/di/injection.dart';
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
                saveImage: usecase.saveImage, shareImage: usecase.shareImage)),
        ChangeNotifierProvider(
          create: (_) => EditorController(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
