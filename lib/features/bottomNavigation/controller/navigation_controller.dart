import 'package:get/get.dart';

class NavigationController extends GetxController{
  final indexSelected = 0.obs;

  void indexChange(int index){
    indexSelected.value = index;
  }
}