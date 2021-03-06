import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_lens/app/models/crop.dart';
import 'package:green_lens/app/modules/home/controllers/dashboard_controller.dart';
import 'package:get/get.dart';

final dc = DashboardController.to;

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? Get.theme.scaffoldBackgroundColor : Colors.white,
      body: ListView(
        children: [
          Text(
            'Green Lens',
            style: TextStyle(
              fontFamily: GoogleFonts.nunito().fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ).paddingOnly(left: 20, bottom: 10),
          Container(
            color: Get.isDarkMode
                ? Get.theme.scaffoldBackgroundColor
                : Colors.white,
            height: 100,
            child: Stack(
              children: [
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: crops.length + 1,
                  itemBuilder: (_, i) => i == crops.length
                      ? SizedBox(width: 60)
                      : CropWidget(crop: crops[i]),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 60,
                    height: 100,
                    color: Get.isDarkMode
                        ? Get.theme.scaffoldBackgroundColor
                        : Colors.white,
                    child: IconButton(
                      onPressed: () {
                        print('');
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CropCard(),
          Card(
            elevation: 5,
            margin: EdgeInsets.all(20),
            child: Container(
              height: 230,
              child: Column(
                children: [
                  Text(
                    'HEAL YOUR CROP',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ).paddingOnly(top: 5, bottom: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Icon(
                            FlutterIcons.picture_ant,
                            size: 30,
                            color: Colors.lightBlue,
                          ),
                          Text(
                            'Select a Photo',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.lightBlue,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(FlutterIcons.details_mco,
                              size: 30, color: Colors.deepPurpleAccent),
                          Text(
                            'See Diagnosis',
                            style: TextStyle(
                                fontSize: 12, color: Colors.deepPurpleAccent),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(FlutterIcons.medicinebox_ant,
                              size: 30, color: Colors.greenAccent[700]),
                          Text(
                            'Get Medicine',
                            style: TextStyle(
                                fontSize: 12, color: Colors.greenAccent[700]),
                          )
                        ],
                      ),
                    ],
                  ).paddingOnly(bottom: 20),
                  OutlinedButton.icon(
                    style: ButtonStyle(overlayColor:
                        MaterialStateProperty.resolveWith<Color>((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.green.withOpacity(0.4);
                      }
                      return Colors.transparent;
                    })),
                    onPressed: () {
                      Get.toNamed('/camera');
                    },
                    icon: Icon(
                      FlutterIcons.camera_enhance_mco,
                      color: Colors.green,
                    ),
                    label: Text(
                      'Take a picture',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                  OutlinedButton.icon(
                    style: ButtonStyle(overlayColor:
                        MaterialStateProperty.resolveWith<Color>((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.lightGreen.withOpacity(0.4);
                      }
                      return Colors.transparent;
                    })),
                    onPressed: () {},
                    icon: Icon(
                      FlutterIcons.photo_album_mdi,
                      color: Colors.lightGreen,
                    ),
                    label: Text(
                      'Choose from gallery',
                      style: TextStyle(color: Colors.lightGreen),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CropCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TweenAnimationBuilder(
        duration: const Duration(milliseconds: 300),
        tween: dc.colorTween,
        builder: (BuildContext context, Color value, Widget child) {
          return ClipRRect(
            borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
            child: Container(
              height: 130,
              color: value.withOpacity(0.6),
              child: Row(
                children: [
                  Card(
                    elevation: 5,
                    color: Get.isDarkMode
                        ? Get.theme.dialogBackgroundColor
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      splashColor:
                          dc.fromHex(dc.selected.value.color).withOpacity(0.3),
                      onTap: () {},
                      child: Container(
                        height: 100,
                        width: Get.width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.ac_unit,
                              color: value,
                            ),
                            Text(
                              'Heal ${dc.selected.value.title}',
                              style: TextStyle(color: value),
                            )
                          ],
                        ),
                      ),
                    ),
                  ).paddingOnly(left: 20),
                  Card(
                    elevation: 5,
                    color: Get.isDarkMode
                        ? Get.theme.dialogBackgroundColor
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      splashColor:
                          dc.fromHex(dc.selected.value.color).withOpacity(0.3),
                      onTap: () {},
                      child: Container(
                        height: 100,
                        width: Get.width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FlutterIcons.more_mco,
                              color: value,
                            ),
                            Text(
                              'Get more details',
                              style: TextStyle(color: value),
                            )
                          ],
                        ),
                      ),
                    ),
                  ).paddingOnly(left: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CropWidget extends StatelessWidget {
  final Crop crop;

  const CropWidget({Key key, this.crop}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TweenAnimationBuilder(
        duration: const Duration(milliseconds: 300),
        tween: dc.colorTween,
        builder: (BuildContext context, Color value, Widget child) {
          return Column(
            children: [
              InkWell(
                onTap: () => dc.selected.value = crop,
                child: Stack(
                  children: [
                    Container(
                      color: dc.selected.value == crop
                          ? value.withOpacity(0.6)
                          : null,
                      height: 100,
                      width: 120,
                      child: Image.asset(
                        crop.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                        width: 120,
                        height: 10,
                        color: Get.isDarkMode
                            ? Get.theme.scaffoldBackgroundColor
                            : Colors.white),
                    Positioned(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        child: Container(
                          width: 100,
                          height: 10.13,
                          color: dc.selected.value == crop
                              ? value.withOpacity(0.6)
                              : null,
                        ),
                      ),
                      left: 10,
                    ),
                    Container(
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10)),
                            child: Container(
                                color: Get.isDarkMode
                                    ? Get.theme.scaffoldBackgroundColor
                                    : Colors.white,
                                height: 100,
                                width: 10),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10)),
                            child: Container(
                                color: Get.isDarkMode
                                    ? Get.theme.scaffoldBackgroundColor
                                    : Colors.white,
                                height: 100,
                                width: 10),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
