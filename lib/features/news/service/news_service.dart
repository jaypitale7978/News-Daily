import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/core/network/api_client.dart';
import 'package:news/features/news/model/article_model.dart';
import 'package:news/features/news/model/news_category.dart';

class NewsService {
  Future<ArticleModel> getTopHeadlines({
    String country = 'us',
    NewsCategory? category,
    int page = 1,
    int pageSize = 10,
  }) async {
    final uri = Uri.parse(
      '${ApiClient.baseUrl}${ApiClient.topHeadlines}',
    ).replace(
      queryParameters: {
        'country': country,
        if (category != null)
          'category': category.value,
        'page': page.toString(),
        'pageSize': pageSize.toString(),
      },
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to fetch top headlines',
      );
    }

    final data = jsonDecode(response.body);

    return ArticleModel.fromJson(data);
  }

  Future<ArticleModel> searchNews({
    required String query,
    int page = 1,
    int pageSize = 10,
  }) async {
    final uri = Uri.parse(
      '${ApiClient.baseUrl}${ApiClient.everything}',
    ).replace(
      queryParameters: {
        'q': query,
        'page': page.toString(),
        'pageSize': pageSize.toString(),
      },
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to search news',
      );
    }

    final data = jsonDecode(response.body);

    return ArticleModel.fromJson(data);
  }
}