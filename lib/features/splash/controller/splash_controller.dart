import 'dart:async';

import 'package:get/get.dart';

import '../../bottomNavigation/view/navigation_page.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();

    _navigateToNavigation();
  }

  Future<void> _navigateToNavigation() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    Get.off(
          () => NavigationPage(),
    );
  }
}