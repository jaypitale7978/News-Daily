import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:news/features/bottomNavigation/view/navigation_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/storage/storage_service/storage_service.dart';
import 'features/bottomNavigation/controller/navigation_controller.dart';
import 'features/news/controller/news_controller.dart';
import 'features/news/service/news_service.dart';
import 'features/saved/controller/saved_news_controller.dart';
import 'features/search/controller/search_news_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  Get.put<StorageService>(
    StorageService(prefs),
  );

  Get.put<NewsService>(
    NewsService(),
  );

  Get.put<NewsController>(
    NewsController(
      Get.find<NewsService>(),
    ),
  );

  Get.put<SearchNewsController>(
    SearchNewsController(
      Get.find<NewsService>(),
    ),
  );

  Get.put<SavedNewsController>(
    SavedNewsController(
      Get.find<StorageService>(),
    ),
  );

  Get.put<NavigationController>(
    NavigationController(),
  );

  runApp(
    const MyApp(),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: NavigationPage()
    );
  }
}

