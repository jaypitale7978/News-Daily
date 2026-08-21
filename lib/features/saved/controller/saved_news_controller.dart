import 'package:get/get.dart';

import '../../../core/storage/storage_service/storage_service.dart';
import '../../news/model/article_model.dart';

class SavedNewsController extends GetxController {
  final StorageService storageService;

  SavedNewsController(this.storageService);

  final savedArticles = <Articles>[].obs;

  @override
  void onInit() {
    super.onInit();

    loadSavedArticles();
  }

  void loadSavedArticles() {
    final articles = storageService.getSavedArticles();

    savedArticles.assignAll(articles);
  }

  bool isSaved(Articles article) {
    if (article.url == null ||
        article.url!.isEmpty) {
      return false;
    }

    return savedArticles.any(
          (savedArticle) =>
      savedArticle.url == article.url,
    );
  }

  Future<void> toggleSaved(Articles article) async {
    if (isSaved(article)) {
      savedArticles.removeWhere(
            (savedArticle) =>
        savedArticle.url == article.url,
      );
    } else {
      savedArticles.add(article);
    }

    await storageService.saveArticles(
      savedArticles.toList(),
    );
  }

  Future<void> clearAll() async {
    savedArticles.clear();

    await storageService.clearSavedArticles();
  }
}