import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/styles/app_colors.dart';
import '../../../app/styles/app_size.dart';
import '../../../app/styles/app_text_styel.dart';
import '../controller/splash_controller.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  final SplashController controller =
  Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }
}