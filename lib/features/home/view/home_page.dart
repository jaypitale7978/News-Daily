import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/app/styles/app_colors.dart';
import 'package:news/app/styles/app_size.dart';
import '../../../app/styles/app_text_styel.dart';
import '../../news/controller/news_controller.dart';
import '../widgets/browse_topics.dart';
import '../widgets/home_header.dart';
import '../widgets/hero_article.dart';
import '../widgets/latest_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NewsController newsController = Get.find<NewsController>();

  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 300) {
      newsController.loadMoreNews();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Obx(
              () {
            if (newsController.isLoading.value &&
                newsController.articles.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.red,
                ),
              );
            }

            if (newsController.errorMessage.value.isNotEmpty &&
                newsController.articles.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Something went wrong',
                      style: AppTextStyle.title,
                    ),
                    const SizedBox(
                      height: AppSize.height10,
                    ),
                    ElevatedButton(
                      onPressed: newsController.refreshNews,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSize.radius8,
                          ),
                        ),
                      ),
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              color: AppColors.red,
              onRefresh: newsController.refreshNews,
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: const EdgeInsets.only(
                  bottom: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeHeader(),

                    const SizedBox(
                      height: AppSize.height20,
                    ),

                    if (newsController.articles.isNotEmpty)
                      HeroArticle(
                        article: newsController.articles.first,
                      ),

                    const SizedBox(
                      height: AppSize.height20,
                    ),
                    const SizedBox(
                      height: AppSize.height15,
                    ),

                    BrowseTopics(
                      newsController: newsController,
                    ),

                    const SizedBox(
                      height: AppSize.height20,
                    ),
                    const SizedBox(
                      height: AppSize.height15,
                    ),

                    LatestSection(
                      articles: newsController.articles,
                    ),

                    if (newsController.isLoadingMore.value)
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppSize.padding20,
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.red,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}