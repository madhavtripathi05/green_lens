import 'package:get/get.dart';

import 'package:green_lens/app/modules/camera/bindings/camera_binding.dart';
import 'package:green_lens/app/modules/camera/views/camera_view.dart';
import 'package:green_lens/app/modules/home/bindings/home_binding.dart';
import 'package:green_lens/app/modules/home/views/home_view.dart';
import 'package:green_lens/app/modules/intro/bindings/intro_binding.dart';
import 'package:green_lens/app/modules/intro/views/intro_view.dart';
import 'package:green_lens/app/modules/login/bindings/login_binding.dart';
import 'package:green_lens/app/modules/login/views/login_view.dart';
import 'package:green_lens/app/modules/registration/bindings/registration_binding.dart';
import 'package:green_lens/app/modules/registration/views/registration_view.dart';
import 'package:green_lens/app/modules/splash/bindings/splash_binding.dart';
import 'package:green_lens/app/modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRATION,
      page: () => RegistrationView(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: _Paths.INTRO,
      page: () => IntroView(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.CAMERA,
      page: () => CameraView(),
      binding: CameraBinding(),
    ),
  ];
}
