import 'package:get/get.dart';
import 'package:camera/camera.dart';

class MyCameraController extends GetxController {
  static final to = Get.find<MyCameraController>();
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

  @override
  void onClose() {
    super.onClose();
  }
}
