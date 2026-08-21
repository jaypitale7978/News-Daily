import 'package:get/get.dart';
import 'package:news/features/news/model/article_model.dart';
import 'package:news/features/news/model/news_category.dart';
import 'package:news/features/news/service/news_service.dart';

class NewsController extends GetxController {
  final NewsService newsService;

  NewsController(this.newsService);

  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final articles = <Articles>[].obs;
  final errorMessage = ''.obs;

  final selectedCategory = Rxn<NewsCategory>();

  int _currentPage = 1;
  final int _pageSize = 10;

  bool _hasMore = true;

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }

  Future<void> fetchNews({
    NewsCategory? category,
    bool loadMore = false,
  }) async {
    if (loadMore) {
      if (isLoadingMore.value || !_hasMore) {
        return;
      }

      isLoadingMore.value = true;
    } else {
      isLoading.value = true;
      errorMessage.value = '';

      _currentPage = 1;
      _hasMore = true;
    }

    try {
      if (!loadMore) {
        selectedCategory.value = category;
      }

      final result = await newsService.getTopHeadlines(
        category: category ?? selectedCategory.value,
        page: _currentPage,
        pageSize: _pageSize,
      );

      final newArticles = result.articles ?? [];

      if (loadMore) {
        articles.addAll(newArticles);
      } else {
        articles.assignAll(newArticles);
      }

      if (newArticles.length < _pageSize) {
        _hasMore = false;
      } else {
        _currentPage++;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> loadMoreNews() async {
    await fetchNews(loadMore: true);
  }

  Future<void> refreshNews() async {
    await fetchNews(
      category: selectedCategory.value,
    );
  }
}