import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  final sc = SplashController.to;
  Widget animatedProgress() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1),
      duration: const Duration(milliseconds: 3000),
      builder: (context, value, _) => Stack(
        children: [
          CircularProgressIndicator(
              value: value, valueColor: AlwaysStoppedAnimation(Colors.white)),
          Opacity(
            opacity: value,
            child: Padding(
              padding: const EdgeInsets.only(left: 5.5, top: 5.5),
              child: Icon(
                FlutterIcons.check_circle_mco,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/green_lens.png'))),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: animatedProgress(),
          ),
        ),
      ),
    );
  }
}
