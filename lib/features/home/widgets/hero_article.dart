import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/app/styles/app_colors.dart';
import 'package:news/app/styles/app_size.dart';

import '../../../app/styles/app_text_styel.dart';
import '../../article /view/article_webview.dart';
import '../../news/model/article_model.dart';

class HeroArticle extends StatelessWidget {
  final Articles article;

  const HeroArticle({
    super.key,
    required this.article,
  });

  void _openArticle() {
    final url = article.url;

    if (url == null || url.isEmpty) {
      return;
    }

    Get.to(
          () => ArticleWebViewPage(
        url: url,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.padding20,
      ),
      child: GestureDetector(
        onTap: _openArticle,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            AppSize.radius22,
          ),
          child: SizedBox(
            height: AppSize.height311,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  article.urlToImage ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      color: AppColors.imagePlaceholder,
                      child: const Icon(
                        Icons.image_outlined,
                        size: 40,
                        color: AppColors.grey,
                      ),
                    );
                  },
                ),

                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.15),
                        Colors.black.withValues(alpha: 0.88),
                      ],
                      stops: const [
                        0.15,
                        0.45,
                        1,
                      ],
                    ),
                  ),
                ),

                Positioned(
                  left: AppSize.padding22,
                  right: AppSize.padding20,
                  bottom: AppSize.padding20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TOP STORY',
                        style: AppTextStyle.topStory.copyWith(
                          color: AppColors.topStory,
                        ),
                      ),

                      const SizedBox(
                        height: AppSize.height10,
                      ),

                      Text(
                        article.title ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.heroTitle.copyWith(
                          color: AppColors.white,
                        ),
                      ),

                      const SizedBox(
                        height: AppSize.height18,
                      ),

                      Text(
                        article.source?.name ?? 'Unknown source',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.heroSource.copyWith(
                          color: AppColors.white.withValues(
                            alpha: 0.75,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}