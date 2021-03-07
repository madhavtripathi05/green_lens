import 'package:get/get.dart';

import '../controllers/new_post_controller.dart';

class NewPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NewPostController>(
      NewPostController(),
    );
  }
}
