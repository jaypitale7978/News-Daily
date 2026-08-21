import 'package:get/instance_manager.dart';
import 'package:news/features/news/controller/news_controller.dart';
import 'package:news/features/news/service/news_service.dart';

class NewsBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<NewsController>(()=> NewsController(Get.find<NewsService>()));
  }

}