import 'package:flutter/material.dart';

import '../../../app/styles/app_colors.dart';
import '../../../app/styles/app_size.dart';
import '../../../app/styles/app_text_styel.dart';
import '../../news/model/article_model.dart';
import 'news_card.dart';
import 'news_divider.dart';

class LatestSection extends StatelessWidget {
  final List<Articles> articles;

  const LatestSection({
    super.key,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    final latestArticles = articles.skip(1).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.padding20,
          ),
          child: Row(
            children: [
              Text(
                'Latest',
                style: AppTextStyle.sectionTitle.copyWith(
                  color: AppColors.black,
                ),
              ),

              const Spacer(),

              Row(
                children: [
                  const Icon(
                    Icons.trending_up_rounded,
                    size: AppSize.icon18,
                    color: AppColors.red,
                  ),

                  const SizedBox(
                    width: AppSize.width5,
                  ),

                  Text(
                    'Trending',
                    style: AppTextStyle.trending.copyWith(
                      color: AppColors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(
          height: AppSize.height20,
        ),

        ...latestArticles.map(
              (article) => Column(
            children: [
              NewsCard(
                article: article,
              ),

              if (article != latestArticles.last)
                const NewsDivider(),
            ],
          ),
        ),
      ],
    );
  }
}