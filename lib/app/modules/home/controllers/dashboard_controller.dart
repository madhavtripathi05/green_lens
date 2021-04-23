import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:green_lens/app/models/crop.dart';
import 'package:green_lens/app/models/weather.dart';
import 'package:green_lens/app/services/db.dart';
import 'package:green_lens/app/services/weather_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
  final scrollController = ScrollController();

  Rx<Crop> selected = crops.first.obs;

  RxBool imageUploaded = false.obs;
  RxBool submitting = false.obs;
  RxBool imageSelected = false.obs;
  RxBool weatherLoaded = false.obs;

  RxString result = ''.obs;
  RxString cityName = ''.obs;

  Rx<Weather> weather = Weather().obs;

  File image;

  WeatherApi weatherApi = WeatherApi();

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

  void generateDialog(bool gallery) => Get.defaultDialog(
      title: "Select a crop to heal",
      content: Container(
        height: Get.height * 0.5,
        width: Get.width * 0.6,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: crops.length,
            itemBuilder: (ctx, idx) {
              return Obx(
                () => RadioListTile<Crop>(
                    value: crops[idx],
                    title: Row(
                      children: [
                        Text(crops[idx].title),
                        Image.asset(crops[idx].imageUrl, height: 50),
                      ],
                    ),
                    groupValue: selected.value,
                    onChanged: (crop) {
                      selected.value = crop;
                      scrollController.animateTo(95.0 * idx,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.decelerate);
                    }),
              );
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

    result.value = jsonDecode(
        await DBService().predict(image, selected.value.id))['prediction'];
    submitting.value = false;
    print(result.value);
  }

  void _showLocationDeniedDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Location is disabled :(',
            style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Enable from settings',
              style: TextStyle(color: Colors.green, fontSize: 16),
            ),
            onPressed: () async {
              await openAppSettings();
              Get.back();
            },
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> fetchWeatherWithLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // return Future.error('Location services are disabled.');
      _showLocationDeniedDialog();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        _showLocationDeniedDialog();
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        _showLocationDeniedDialog();
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    var city = await weatherApi.getCityNameFromLocation(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude);
    cityName.value = city;
    print(cityName.value);

    weather.value = await weatherApi.getWeatherData(city);

    weather.value.forecast = await weatherApi.getForecast(city);
    if (!weather.value.isBlank || !cityName.isBlank) weatherLoaded.value = true;
  }

  @override
  void onInit() async {
    await fetchWeatherWithLocation();
    super.onInit();
  }
  //assets/images/test/apple/Apple Scab.JPG
}
