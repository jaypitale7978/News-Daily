import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../features/news/model/article_model.dart';
class StorageService {
  static const String _savedArticlesKey = 'saved_articles';

  final SharedPreferences prefs;

  StorageService(this.prefs);

  Future<void> saveArticles(List<Articles> articles) async {
    final data = articles
        .map((article) => jsonEncode(article.toJson()))
        .toList();

    await prefs.setStringList(
      _savedArticlesKey,
      data,
    );
  }

  List<Articles> getSavedArticles() {
    final data = prefs.getStringList(
      _savedArticlesKey,
    );

    if (data == null || data.isEmpty) {
      return [];
    }

    return data.map((item) {
      return Articles.fromJson(
        jsonDecode(item),
      );
    }).toList();
  }

  Future<void> clearSavedArticles() async {
    await prefs.remove(_savedArticlesKey);
  }
}