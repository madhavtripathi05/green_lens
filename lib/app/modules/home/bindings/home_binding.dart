import 'package:get/get.dart';
import 'package:green_lens/app/modules/home/controllers/dashboard_controller.dart';
import '../controllers/profile_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
  }
}
