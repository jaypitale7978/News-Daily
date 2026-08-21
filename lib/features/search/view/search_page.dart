import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/app/styles/app_colors.dart';
import 'package:news/app/styles/app_size.dart';
import 'package:news/app/styles/app_text_styel.dart';

import '../../bottomNavigation/controller/navigation_controller.dart';
import '../controller/search_news_controller.dart';
import '../widget/article_divider.dart';
import '../widget/search_article.dart';
import '../widget/trending_chip.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final SearchNewsController searchController =
  Get.find<SearchNewsController>();

  final NavigationController navigationController =
  Get.find<NavigationController>();

  final TextEditingController textController =
  TextEditingController();

  final List<String> trending = [
    'Artificial Intelligence',
    'Paris Olympics',
    'Federal Reserve',
    'Climate Summit',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Obx(
              () {
            final hasQuery =
                searchController.searchQuery.value.isNotEmpty;

            final hasArticles =
                searchController.articles.isNotEmpty;

            final isLoading =
                searchController.isLoading.value;

            final hasError =
                searchController.errorMessage.value.isNotEmpty;

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSize.padding16,
                    AppSize.padding20,
                    AppSize.padding16,
                    0,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        _buildTitle(),

                        const SizedBox(
                          height: AppSize.height20,
                        ),

                        _buildSearchRow(),

                        const SizedBox(
                          height: AppSize.height20,
                        ),

                        if (!hasQuery) ...[
                          _buildSectionTitle('TRENDING'),

                          const SizedBox(
                            height: AppSize.height14,
                          ),

                          _buildTrending(),

                          if (searchController
                              .recentSearches
                              .isNotEmpty) ...[
                            const SizedBox(
                              height: AppSize.height28,
                            ),

                            _buildSectionTitle('RECENT'),

                            const SizedBox(
                              height: AppSize.height14,
                            ),

                            _buildRecentSearches(),
                          ],

                          const SizedBox(
                            height: AppSize.height20,
                          ),
                        ],

                        if (isLoading && !hasArticles)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(
                                AppSize.padding28,
                              ),
                              child: CircularProgressIndicator(
                                color: AppColors.red,
                              ),
                            ),
                          ),

                        if (!isLoading &&
                            hasQuery &&
                            !hasArticles &&
                            !hasError)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(
                                AppSize.padding28,
                              ),
                              child: Text(
                                'No news found',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.headerTitle,
                                ),
                              ),
                            ),
                          ),

                        if (hasError && !hasArticles)
                          _buildError(),
                      ],
                    ),
                  ),
                ),

                if (hasArticles)
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.width15,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          final article =
                          searchController.articles[index];

                          if (index ==
                              searchController.articles.length - 1) {
                            searchController.loadMoreNews();
                          }

                          return Column(
                            children: [
                              SearchArticle(
                                article: article,
                              ),
                              if (index !=
                                  searchController.articles.length - 1)
                                const ArticleDivider(),
                            ],
                          );
                        },
                        childCount:
                        searchController.articles.length,
                      ),
                    ),
                  ),

                if (searchController.isLoadingMore.value)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(
                        AppSize.padding20,
                      ),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),

                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: AppSize.height32,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Search',
      style: AppTextStyle.headerTitle.copyWith(
        color: AppColors.headerTitle,
      ),
    );
  }

  Widget _buildSearchRow() {
    final hasText = textController.text.trim().isNotEmpty;

    return Row(
      children: [
        if (!hasText) ...[
          GestureDetector(
            onTap: () {
              textController.clear();

              searchController.clearSearch();

              FocusManager.instance.primaryFocus?.unfocus();

              navigationController.indexChange(0);
            },
            behavior: HitTestBehavior.opaque,
            child: const SizedBox(
              width: AppSize.width20 + AppSize.width20,
              height: AppSize.height78 - AppSize.height20,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: AppSize.icon20,
                color: AppColors.headerTitle,
              ),
            ),
          ),

          const SizedBox(
            width: AppSize.width5,
          ),
        ],

        Expanded(
          child: Container(
            height: 59,
            decoration: BoxDecoration(
              color: AppColors.imagePlaceholder,
              borderRadius: BorderRadius.circular(
                AppSize.radius22,
              ),
            ),
            child: TextField(
              controller: textController,
              textInputAction: TextInputAction.search,
              onChanged: searchController.onSearchChanged,
              style: AppTextStyle.title.copyWith(
                color: const Color(0xFF344054),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,

                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.greyish,
                  size: AppSize.icon20,
                ),

                hintText: 'Topics, sources, keywords...',

                hintStyle: AppTextStyle.title.copyWith(
                  color: AppColors.greyish,
                ),

                suffixIcon: hasText
                    ? IconButton(
                  onPressed: () {
                    textController.clear();

                    searchController.clearSearch();

                    FocusManager.instance
                        .primaryFocus
                        ?.unfocus();
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: AppColors.greyish,
                    size: AppSize.icon20,
                  ),
                )
                    : null,

                contentPadding: const EdgeInsets.symmetric(
                  vertical: AppSize.padding16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyle.newsSource.copyWith(
        color: AppColors.greyish,
        fontSize: 15,
      ),
    );
  }

  Widget _buildTrending() {
    return Wrap(
      spacing: AppSize.width10,
      runSpacing: AppSize.height10,
      children: trending.map(
            (item) {
          return TrendingChip(
            text: item,
            onTap: () {
              textController.text = item;

              searchController.searchNews(item);
            },
          );
        },
      ).toList(),
    );
  }

  Widget _buildRecentSearches() {
    return Column(
      children: searchController.recentSearches.map(
            (query) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.history_rounded,
              color: AppColors.greyish,
            ),
            title: Text(
              query,
              style: AppTextStyle.title.copyWith(
                color: const Color(0xFF344054),
              ),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.close_rounded,
                color: AppColors.greyish,
                size: AppSize.icon20,
              ),
              onPressed: () {
                searchController.removeRecentSearch(query);
              },
            ),
            onTap: () {
              textController.text = query;

              searchController.searchNews(query);
            },
          );
        },
      ).toList(),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          AppSize.padding28,
        ),
        child: Column(
          children: [
            Text(
              'Something went wrong',
              style: AppTextStyle.title.copyWith(
                color: AppColors.headerTitle,
              ),
            ),

            const SizedBox(
              height: AppSize.height10,
            ),

            ElevatedButton(
              onPressed: () {
                searchController.searchNews(
                  searchController.searchQuery.value,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSize.padding20,
                  vertical: AppSize.padding12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppSize.radius8,
                  ),
                ),
                elevation: 0,
              ),
              child: Text(
                'Try Again',
                style: AppTextStyle.subtitle.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}