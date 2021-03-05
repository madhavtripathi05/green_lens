import 'dart:async';

import 'package:get/get.dart';
import '../../../../utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  static final to = Get.find<SplashController>();
  SharedPreferences prefs;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    String theme = prefs.getString('theme');
    bool introShown = prefs.getBool('intro') ?? false;
    Get.changeTheme(theme == 'dark' ? darkTheme : lightTheme);
    Timer(Duration(seconds: 3), () {
      Get.offNamed(introShown ? '/login' : '/intro');
    });
    prefs.setBool('intro', false);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
