import 'package:flutter/material.dart';

import '../../../app/styles/app_colors.dart';
import '../../../app/styles/app_size.dart';
import '../../../app/styles/app_text_styel.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];

    const weekdays = [
      'MONDAY',
      'TUESDAY',
      'WEDNESDAY',
      'THURSDAY',
      'FRIDAY',
      'SATURDAY',
      'SUNDAY',
    ];

    final currentDate =
        '${weekdays[now.weekday - 1]}, '
        '${months[now.month - 1]} ${now.day}';

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSize.padding20,
        AppSize.padding8,
        AppSize.padding20,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentDate,
            style: AppTextStyle.headerDate.copyWith(
              color: AppColors.headerDate,
            ),
          ),

          const SizedBox(
            height: AppSize.height5,
          ),

          Row(
            children: [
              Text(
                'News',
                style: AppTextStyle.headerTitle.copyWith(
                  color: AppColors.headerTitle,
                ),
              ),

              const SizedBox(
                width: AppSize.width10,
              ),

              Text(
                'Daily',
                style: AppTextStyle.headerTitle.copyWith(
                  color: AppColors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}