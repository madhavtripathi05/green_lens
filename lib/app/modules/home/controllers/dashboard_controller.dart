import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_lens/app/models/crop.dart';

final crops = [
  Crop(
      id: 'apple',
      title: 'Apple',
      imageUrl: 'assets/images/apple.png',
      color: '#fa1e0e'),
  Crop(
      id: 'banana',
      title: 'Banana',
      imageUrl: 'assets/images/banana.png',
      color: '#f4d160'),
  Crop(
      id: 'blueberry',
      title: 'Blueberry',
      imageUrl: 'assets/images/blueberry.png',
      color: '#4f86f7'),
  Crop(
      id: 'cherry',
      title: 'Cherry',
      imageUrl: 'assets/images/cherry.png',
      color: '#f7022a'),
  Crop(
      id: 'corn',
      title: 'Corn',
      imageUrl: 'assets/images/corn.png',
      color: '#fbec5d'),
  Crop(
      id: 'grape',
      title: 'Grape',
      imageUrl: 'assets/images/grape.png',
      color: '#61b15a'),
  Crop(
      id: 'orange',
      title: 'Orange',
      imageUrl: 'assets/images/orange.png',
      color: '#ffa500'),
  Crop(
      id: 'peach',
      title: 'Peach',
      imageUrl: 'assets/images/peach.png',
      color: '#ff886c'),
  Crop(
      id: 'bell_pepper',
      title: 'Pepper',
      imageUrl: 'assets/images/bell_pepper.png',
      color: '#fa1e0e'),
  Crop(
      id: 'potato',
      title: 'Potato',
      imageUrl: 'assets/images/potato.png',
      color: '#bd9354'),
  Crop(
      id: 'soybean',
      title: 'Soybean',
      imageUrl: 'assets/images/soybean.png',
      color: '#6f634b'),
  Crop(
      id: 'squash',
      title: 'Squash',
      imageUrl: 'assets/images/squash.png',
      color: '#f2ab15'),
  Crop(
      id: 'strawberry',
      title: 'Strawberry',
      imageUrl: 'assets/images/strawberry.png',
      color: '#c83f49'),
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
