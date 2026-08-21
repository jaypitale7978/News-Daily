import 'package:flutter/material.dart';

import '../../../app/styles/app_colors.dart';
import '../../../app/styles/app_size.dart';
import '../../../app/styles/app_text_styel.dart';

class TopicChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const TopicChip({
    super.key,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.padding18,
          vertical: AppSize.padding12,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? color
              : color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(
            AppSize.radius24,
          ),
          border: Border.all(
            color: color,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyle.topicChip.copyWith(
            color: isSelected ? AppColors.white : color,
          ),
        ),
      ),
    );
  }
}