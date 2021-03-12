import 'package:get/get.dart';

import '../../community/views/community_view.dart';
import '../views/dashboard_view.dart';
import '../views/user_profile.dart';

class HomeController extends GetxController {
  static final to = Get.find<HomeController>();
  RxInt index = 0.obs;
  var views = [Dashboard(), CommunityView(), UserProfile()];
  void changeIndex(int newIndex) {
    index.value = newIndex;
  }

  @override
  void onInit() async {
    try {} catch (e) {
      print(e);
    }
    super.onInit();
  }
}
