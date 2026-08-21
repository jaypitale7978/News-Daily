import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/app/styles/app_colors.dart';
import 'package:news/app/styles/app_size.dart';

import '../../../app/styles/app_text_styel.dart';
import '../../news/controller/news_controller.dart';
import '../../news/model/news_category.dart';
import 'topic_chip.dart';

class BrowseTopics extends StatelessWidget {
  final NewsController newsController;

  const BrowseTopics({
    super.key,
    required this.newsController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.padding20,
          ),
          child: Text(
            'Browse Topics',
            style: AppTextStyle.title,
          ),
        ),

        const SizedBox(
          height: AppSize.height15,
        ),

        SizedBox(
          height: 49,
          child: Obx(
                () => ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(
                left: AppSize.padding20,
              ),
              children: [
                TopicChip(
                  label: 'Technology',
                  color: AppColors.blue,
                  isSelected:
                  newsController.selectedCategory.value ==
                      NewsCategory.technology,
                  onTap: () {
                    newsController.fetchNews(
                      category: NewsCategory.technology,
                    );
                  },
                ),

                const SizedBox(
                  width: AppSize.width10,
                ),

                TopicChip(
                  label: 'Business',
                  color: AppColors.success,
                  isSelected:
                  newsController.selectedCategory.value ==
                      NewsCategory.business,
                  onTap: () {
                    newsController.fetchNews(
                      category: NewsCategory.business,
                    );
                  },
                ),

                const SizedBox(
                  width: AppSize.width10,
                ),

                TopicChip(
                  label: 'Sports',
                  color: AppColors.darkOrange,
                  isSelected:
                  newsController.selectedCategory.value ==
                      NewsCategory.sports,
                  onTap: () {
                    newsController.fetchNews(
                      category: NewsCategory.sports,
                    );
                  },
                ),

                const SizedBox(
                  width: AppSize.width10,
                ),

                TopicChip(
                  label: 'Entertainment',
                  color: AppColors.darkBlue,
                  isSelected:
                  newsController.selectedCategory.value ==
                      NewsCategory.entertainment,
                  onTap: () {
                    newsController.fetchNews(
                      category: NewsCategory.entertainment,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}