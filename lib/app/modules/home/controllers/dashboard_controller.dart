import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_lens/app/models/crop.dart';

final crops = [
  Crop(
      id: 'banana',
      title: 'Banana',
      imageUrl: 'assets/images/banana.png',
      color: '#f4d160'),
  Crop(
      id: 'apple',
      title: 'Apple',
      imageUrl: 'assets/images/apple.png',
      color: '#fa1e0e'),
  Crop(
      id: 'cabbage',
      title: 'Cabbage',
      imageUrl: 'assets/images/cabbage.png',
      color: '#61b15a'),
  Crop(
      id: 'bell_pepper',
      title: 'Bell Pepper',
      imageUrl: 'assets/images/bell_pepper.png',
      color: '#fa1e0e'),
  Crop(
      id: 'potato',
      title: 'Potato',
      imageUrl: 'assets/images/potato.png',
      color: '#bd9354'),
  Crop(
      id: 'tomato',
      title: 'Tomato',
      imageUrl: 'assets/images/tomato.png',
      color: '#fa1e0e'),
];

class DashboardController extends GetxController {
  static final to = Get.find<DashboardController>();
  Rx<Crop> selected = crops.first.obs;

  ColorTween get colorTween => ColorTween(
      begin: fromHex(selected.value.color), end: fromHex(selected.value.color));

  Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
