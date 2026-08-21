import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../news/model/article_model.dart';
import '../../news/service/news_service.dart';

class SearchNewsController extends GetxController {
  final NewsService newsService;

  SearchNewsController(this.newsService);

  final isLoading = false.obs;
  final isLoadingMore = false.obs;

  final articles = <Articles>[].obs;

  final errorMessage = ''.obs;
  final searchQuery = ''.obs;

  final recentSearches = <String>[].obs;

  int _currentPage = 1;

  static const int _pageSize = 10;

  bool _hasMore = true;

  Timer? _searchDebounce;

  void onSearchChanged(String value) {
    _searchDebounce?.cancel();

    final query = value.trim();

    searchQuery.value = query;

    if (query.isEmpty) {
      clearSearch();
      return;
    }

    _searchDebounce = Timer(
      const Duration(milliseconds: 500),
          () {
        searchNews(query);
      },
    );
  }

  Future<void> searchNews(String query) async {
    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      clearSearch();
      return;
    }

    _searchDebounce?.cancel();

    try {
      isLoading.value = true;
      isLoadingMore.value = false;

      errorMessage.value = '';

      _currentPage = 1;
      _hasMore = true;

      searchQuery.value = trimmedQuery;

      articles.clear();

      debugPrint('================================');
      debugPrint('SEARCH START');
      debugPrint('Query: $trimmedQuery');
      debugPrint('Page: $_currentPage');
      debugPrint('Page Size: $_pageSize');

      final result = await newsService.searchNews(
        query: trimmedQuery,
        page: _currentPage,
        pageSize: _pageSize,
      );

      final newArticles = result.articles ?? [];

      debugPrint(
        'SEARCH RESULT: ${newArticles.length} articles',
      );

      articles.assignAll(newArticles);

      if (newArticles.length < _pageSize) {
        _hasMore = false;
      } else {
        _currentPage++;
      }

      _addRecentSearch(trimmedQuery);

      debugPrint('SEARCH SUCCESS');
      debugPrint('Has More: $_hasMore');
      debugPrint('Next Page: $_currentPage');
      debugPrint('================================');
    } catch (e, stackTrace) {
      debugPrint('================================');
      debugPrint('SEARCH ERROR');
      debugPrint('$e');
      debugPrint('$stackTrace');
      debugPrint('================================');

      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreNews() async {
    if (isLoadingMore.value ||
        !_hasMore ||
        searchQuery.value.isEmpty) {
      return;
    }

    try {
      isLoadingMore.value = true;

      debugPrint(
        'SEARCH LOAD MORE: '
            '${searchQuery.value} '
            'page=$_currentPage',
      );

      final result = await newsService.searchNews(
        query: searchQuery.value,
        page: _currentPage,
        pageSize: _pageSize,
      );

      final newArticles = result.articles ?? [];

      debugPrint(
        'LOAD MORE RESULT: ${newArticles.length}',
      );

      if (newArticles.isEmpty) {
        _hasMore = false;
        return;
      }

      articles.addAll(newArticles);

      if (newArticles.length < _pageSize) {
        _hasMore = false;
      } else {
        _currentPage++;
      }
    } catch (e, stackTrace) {
      debugPrint('SEARCH LOAD MORE ERROR: $e');
      debugPrint('$stackTrace');

      errorMessage.value = e.toString();
    } finally {
      isLoadingMore.value = false;
    }
  }

  void _addRecentSearch(String query) {
    recentSearches.remove(query);

    recentSearches.insert(0, query);

    if (recentSearches.length > 5) {
      recentSearches.removeLast();
    }
  }

  void removeRecentSearch(String query) {
    recentSearches.remove(query);
  }

  void clearSearch() {
    _searchDebounce?.cancel();

    searchQuery.value = '';

    articles.clear();

    _currentPage = 1;

    _hasMore = true;

    errorMessage.value = '';

    isLoading.value = false;

    isLoadingMore.value = false;
  }

  @override
  void onClose() {
    _searchDebounce?.cancel();
    super.onClose();
  }
}