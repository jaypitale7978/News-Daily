import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/app/styles/app_colors.dart';
import 'package:news/app/styles/app_size.dart';

import '../../../app/styles/app_text_styel.dart';
import '../controller/navigation_controller.dart';

class BottomNavigationbar extends StatelessWidget {
  BottomNavigationbar({super.key});

  final NavigationController controller =
  Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.grey.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Obx(
            () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavWidget(
              icon: Icons.home_outlined,
              activeIcon: Icons.home_rounded,
              label: 'Home',
              selected: controller.indexSelected.value == 0,
              onTap: () => controller.indexChange(0),
            ),
            BottomNavWidget(
              icon: Icons.search_outlined,
              activeIcon: Icons.search_rounded,
              label: 'Search',
              selected: controller.indexSelected.value == 1,
              onTap: () => controller.indexChange(1),
            ),
            BottomNavWidget(
              icon: Icons.bookmark_border_rounded,
              activeIcon: Icons.bookmark_rounded,
              label: 'Saved',
              selected: controller.indexSelected.value == 2,
              onTap: () => controller.indexChange(2),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavWidget extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const BottomNavWidget({
    super.key,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.red : AppColors.greyish;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              selected ? activeIcon : icon,
              color: color,
              size: AppSize.icon20,
            ),
            const SizedBox(height: AppSize.height5),
            Text(
              label,
              style: AppTextStyle.subtitle.copyWith(
                color: color,
                fontWeight:
                selected ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}