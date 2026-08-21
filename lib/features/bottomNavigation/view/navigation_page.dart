import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/features/saved/view/saved_page.dart';

import '../controller/navigation_controller.dart';
import '../../home/view/home_page.dart';
import '../../search/view/search_page.dart';
import '../view/bottom_navigationBar.dart';

class NavigationPage extends StatelessWidget {
  NavigationPage({super.key});

  final NavigationController controller =
  Get.find<NavigationController>();

  final List<Widget> pages = [
    HomePage(),
    SearchPage(),
    SavedPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => IndexedStack(
          index: controller.indexSelected.value,
          children: pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationbar(),
    );
  }
}