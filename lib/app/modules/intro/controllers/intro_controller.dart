import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroItem {
  IntroItem({
    this.title,
    this.category,
    this.imageUrl,
  });

  final String title;
  final String category;
  final String imageUrl;
}

class IntroController extends GetxController {
  static final to = Get.find<IntroController>();
  RxInt index = 0.obs;
  final pageController = PageController(viewportFraction: 0.85);
  final sampleItems = <IntroItem>[
    new IntroItem(
      title: 'Smartly manage your plants by our ML Model.',
      category: 'SMART',
      imageUrl: 'https://picsum.photos/800',
    ),
    new IntroItem(
      title: 'Elegant and easy to use UI',
      category: 'EASE OF USE',
      imageUrl: 'https://picsum.photos/900',
    ),
    new IntroItem(
      title: 'Share your experience with others.',
      category: 'COMMUNITY',
      imageUrl: 'https://picsum.photos/1000',
    ),
  ];
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
