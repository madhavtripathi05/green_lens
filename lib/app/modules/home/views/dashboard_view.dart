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
                    height: 110,
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
            margin: EdgeInsets.all(20),
            child: Container(
              height: 200,
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
                            FlutterIcons.camera_ant,
                            size: 40,
                          ),
                          Text('Take a Picture')
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            FlutterIcons.details_mco,
                            size: 40,
                          ),
                          Text('See Diagnosis')
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            FlutterIcons.medicinebox_ant,
                            size: 40,
                          ),
                          Text('Get Medicine')
                        ],
                      ),
                    ],
                  ).paddingOnly(bottom: 20),
                  OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(FlutterIcons.camera_control_mco),
                      label: Text('Take a picture'))
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        color: Get.isDarkMode
                            ? Get.theme.scaffoldBackgroundColor
                            : Colors.white,
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
                              'This is some text',
                              style: TextStyle(color: value),
                            )
                          ],
                        ),
                      ),
                    ),
                  ).paddingOnly(left: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Get.isDarkMode
                          ? Get.theme.scaffoldBackgroundColor
                          : Colors.white,
                      height: 100,
                      width: Get.width * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_alarm,
                            color: value,
                          ),
                          Text(
                            'This is another text',
                            style: TextStyle(color: value),
                          )
                        ],
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
                  fit: StackFit.passthrough,
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
                          height: 10,
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
