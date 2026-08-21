import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/styles/app_colors.dart';
import '../../../app/styles/app_size.dart';
import '../../../app/styles/app_text_styel.dart';
import '../../article /view/article_webview.dart';
import '../../news/model/article_model.dart';
import '../../saved/controller/saved_news_controller.dart';

class NewsCard extends StatelessWidget {
  final Articles article;

  NewsCard({
    super.key,
    required this.article,
  });

  final SavedNewsController savedController =
  Get.find<SavedNewsController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (article.url != null &&
            article.url!.isNotEmpty) {
          Get.to(
                () => ArticleWebViewPage(
              url: article.url!,
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.padding16,
          vertical: AppSize.padding14,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.source?.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.newsSource.copyWith(
                      color: AppColors.red,
                    ),
                  ),

                  const SizedBox(
                    height: AppSize.height5,
                  ),

                  Text(
                    article.title ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.newsTitle.copyWith(
                      color: AppColors.headerTitle,
                    ),
                  ),

                  const SizedBox(
                    height: AppSize.height10,
                  ),

                  Text(
                    article.publishedAt ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.newsMeta.copyWith(
                      color: AppColors.greyish,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              width: AppSize.width10,
            ),

            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AppSize.radius12,
                  ),
                  child: SizedBox(
                    width: AppSize.width120,
                    height: AppSize.height98,
                    child: article.urlToImage != null &&
                        article.urlToImage!.isNotEmpty
                        ? Image.network(
                      article.urlToImage!,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) {
                        return Container(
                          color: AppColors.imagePlaceholder,
                          child: const Icon(
                            Icons
                                .image_not_supported_outlined,
                            color: AppColors.greyish,
                            size: AppSize.icon20,
                          ),
                        );
                      },
                    )
                        : Container(
                      color: AppColors.imagePlaceholder,
                      child: const Icon(
                        Icons.image_outlined,
                        color: AppColors.greyish,
                        size: AppSize.icon20,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: AppSize.padding8,
                  right: AppSize.padding8,
                  child: Obx(
                        () {
                      final isSaved =
                      savedController.isSaved(article);

                      return GestureDetector(
                        onTap: () {
                          savedController.toggleSaved(article);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: AppSize.height36,
                          height: AppSize.height36,
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(
                              alpha: 0.9,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isSaved
                                ? Icons.bookmark_rounded
                                : Icons
                                .bookmark_border_rounded,
                            size: AppSize.icon20,
                            color: isSaved
                                ? AppColors.red
                                : AppColors.headerTitle,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}