import 'package:camera/camera.dart';
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

  List<CameraDescription> cameras;
  @override
  void onInit() async {
    try {
      cameras = await availableCameras();
    } catch (e) {
      print(e);
    }
    super.onInit();
  }
}
