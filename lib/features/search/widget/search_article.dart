import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/app/styles/app_colors.dart';
import 'package:news/app/styles/app_size.dart';
import 'package:news/app/styles/app_text_styel.dart';

import '../../article /view/article_webview.dart';
import '../../news/model/article_model.dart';
import '../../saved/controller/saved_news_controller.dart';

class SearchArticle extends StatelessWidget {
  final Articles article;

  SearchArticle({
    super.key,
    required this.article,
  });

  final SavedNewsController savedNewsController =
  Get.find<SavedNewsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () {
        final isSaved =
        savedNewsController.isSaved(article);

        return SizedBox(
          height: AppSize.height98 + AppSize.height30,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _openArticle();
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: AppSize.padding8,
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.source?.name ?? 'NEWS',
                          maxLines: 1,
                          overflow:
                          TextOverflow.ellipsis,
                          style:
                          AppTextStyle.newsSource.copyWith(
                            color: AppColors.technology,
                          ),
                        ),

                        const SizedBox(
                          height: AppSize.height10,
                        ),

                        Text(
                          article.title ?? '',
                          maxLines: 2,
                          overflow:
                          TextOverflow.ellipsis,
                          style:
                          AppTextStyle.newsTitle.copyWith(
                            color: AppColors.headerTitle,
                          ),
                        ),

                        const Spacer(),

                        Text(
                          article.author ?? 'Unknown',
                          maxLines: 1,
                          overflow:
                          TextOverflow.ellipsis,
                          style:
                          AppTextStyle.newsMeta.copyWith(
                            color: AppColors.greyish,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: AppSize.width120,
                height: AppSize.height98,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _openArticle();
                      },
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(
                          AppSize.radius20,
                        ),
                        child: Image.network(
                          article.urlToImage ?? '',
                          width: AppSize.width120,
                          height: AppSize.height98,
                          fit: BoxFit.cover,
                          errorBuilder: (
                              context,
                              error,
                              stackTrace,
                              ) {
                            return Container(
                              color:
                              AppColors.imagePlaceholder,
                              child: const Icon(
                                Icons.image_outlined,
                                color:
                                AppColors.greyish,
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    Positioned(
                      right: AppSize.padding4,
                      top: AppSize.padding4,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            savedNewsController
                                .toggleSaved(article);
                          },
                          borderRadius:
                          BorderRadius.circular(20),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration:
                            BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black
                                      .withValues(
                                    alpha: 0.08,
                                  ),
                                  blurRadius: 6,
                                  offset:
                                  const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              isSaved
                                  ? Icons
                                  .bookmark_rounded
                                  : Icons
                                  .bookmark_border_rounded,
                              size: AppSize.icon18,
                              color: isSaved
                                  ? AppColors.red
                                  : AppColors.greyish,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openArticle() {
    final url = article.url;

    if (url == null || url.isEmpty) {
      Get.snackbar(
        'Article unavailable',
        'This article does not have a valid URL.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Get.to(
          () => ArticleWebViewPage(
        url: url,
      ),
      transition: Transition.rightToLeft,
    );
  }
}