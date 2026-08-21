import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/app/styles/app_colors.dart';
import 'package:news/app/styles/app_size.dart';
import 'package:news/app/styles/app_text_styel.dart';

import '../../bottomNavigation/controller/navigation_controller.dart';
import '../../search/widget/article_divider.dart';
import '../../search/widget/search_article.dart';
import '../controller/saved_news_controller.dart';

class SavedPage extends StatelessWidget {
  SavedPage({super.key});

  final SavedNewsController savedController =
  Get.find<SavedNewsController>();

  final NavigationController navigationController =
  Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Obx(
              () {
            final articles = savedController.savedArticles;

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
                        _buildHeader(),

                        const SizedBox(
                          height: AppSize.height20,
                        ),

                        if (articles.isEmpty)
                          _buildEmptyState(),

                        if (articles.isNotEmpty)
                          _buildClearAll(),
                      ],
                    ),
                  ),
                ),

                if (articles.isNotEmpty)
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.padding16,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          final article = articles[index];

                          return Column(
                            children: [
                              SearchArticle(
                                article: article,
                              ),

                              if (index != articles.length - 1)
                                const ArticleDivider(),
                            ],
                          );
                        },
                        childCount: articles.length,
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

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            navigationController.indexChange(0);
          },
          behavior: HitTestBehavior.opaque,
          child: const SizedBox(
            width: AppSize.height36,
            height: AppSize.height36,
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: AppSize.icon20,
              color: AppColors.headerTitle,
            ),
          ),
        ),

        const SizedBox(
          width: AppSize.width10,
        ),

        Expanded(
          child: Text(
            'Saved',
            style: AppTextStyle.headerTitle.copyWith(
              color: AppColors.headerTitle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClearAll() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Get.dialog(
              AlertDialog(
                title: const Text('Clear saved articles?'),
                content: const Text(
                  'All saved articles will be removed.',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      savedController.clearAll();
                      Get.back();
                    },
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        color: AppColors.red,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          child: Text(
            'Clear All',
            style: AppTextStyle.title.copyWith(
              color: AppColors.red,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return SizedBox(
      height: 350,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.bookmark_border_rounded,
              size: 55,
              color: AppColors.greyish,
            ),

            const SizedBox(
              height: AppSize.height14,
            ),

            Text(
              'No saved articles',
              textAlign: TextAlign.center,
              style: AppTextStyle.title.copyWith(
                color: AppColors.headerTitle,
              ),
            ),

            const SizedBox(
              height: AppSize.height5,
            ),

            Text(
              'Articles you save will appear here.',
              textAlign: TextAlign.center,
              style: AppTextStyle.subtitle.copyWith(
                color: AppColors.greyish,
              ),
            ),
          ],
        ),
      ),
    );
  }
}