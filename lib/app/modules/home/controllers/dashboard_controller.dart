import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_lens/app/models/crop.dart';
import 'package:green_lens/app/services/db.dart';
import 'package:image_picker/image_picker.dart';

final crops = [
  Crop(
      id: 'apple',
      title: 'Apple',
      imageUrl: 'assets/images/apple.png',
      color: '#fa1e0e'),
  Crop(
      id: 'cherry',
      title: 'Cherry',
      imageUrl: 'assets/images/cherry.png',
      color: '#f7022a'),
  Crop(
      id: 'corn',
      title: 'Corn',
      imageUrl: 'assets/images/corn.png',
      color: '#FBEC5D'),
  Crop(
      id: 'grape',
      title: 'Grape',
      imageUrl: 'assets/images/grape.png',
      color: '#61b15a'),
  Crop(
      id: 'peach',
      title: 'Peach',
      imageUrl: 'assets/images/peach.png',
      color: '#ff886c'),
  Crop(
      id: 'pepper',
      title: 'Pepper',
      imageUrl: 'assets/images/pepper.png',
      color: '#fa1e0e'),
  Crop(
      id: 'potato',
      title: 'Potato',
      imageUrl: 'assets/images/potato.png',
      color: '#bd9354'),
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

  RxBool imageUploaded = false.obs;
  RxBool submitting = false.obs;
  RxBool imageSelected = false.obs;

  RxString results = ''.obs;

  File image;

  ColorTween get colorTween => ColorTween(
      begin: fromHex(selected.value.color), end: fromHex(selected.value.color));

  Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;
    if (gallery) {
      pickedFile = await picker.getImage(
          source: ImageSource.gallery, maxHeight: 224, maxWidth: 224);
    } else {
      pickedFile = await picker.getImage(
          source: ImageSource.camera, maxHeight: 224, maxWidth: 224);
    }
    if (pickedFile != null) {
      image = File(pickedFile.path);
      imageSelected.value = true;
      await predictFromImage();
    } else {
      print('No image selected.');
    }
  }

  void onChanged(Crop crop) => selected.value = crop;

  void generateDialog(bool gallery) => Get.defaultDialog(
      title: "Select a crop to heal",
      content: Container(
        height: Get.height * 0.5,
        width: Get.width * 0.6,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: crops.length,
            itemBuilder: (ctx, idx) {
              return Obx(() => RadioListTile<Crop>(
                  value: crops[idx],
                  title: Row(
                    children: [
                      Text(crops[idx].title),
                      Image.asset(crops[idx].imageUrl, height: 50),
                    ],
                  ),
                  groupValue: selected.value,
                  onChanged: onChanged));
            }),
      ),
      confirm: IconButton(
          icon: Icon(Icons.check),
          onPressed: () async {
            Get.back();
            await getImage(gallery);
          }));

  Future predictFromImage() async {
    print('predicting');
    submitting.value = true;

    results.value = jsonDecode(
        await DBService().predict(image, selected.value.id))['prediction'];
    submitting.value = false;
    print(results.value);
  }
}
