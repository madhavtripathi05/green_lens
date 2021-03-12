import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_lens/app/models/crop.dart';
import 'package:green_lens/app/modules/home/controllers/dashboard_controller.dart';
import 'package:get/get.dart';

var dc = DashboardController.to;

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? Get.theme.scaffoldBackgroundColor : Colors.white,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Text(
            'Green Lens',
            style: TextStyle(
              fontFamily: GoogleFonts.nunito().fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ).paddingOnly(left: 20, bottom: 10),
          CropsAnimatedList(),
          CropCard(),
          CenterCard(),
          PredictionCard(),
        ],
      ),
    );
  }
}

class PredictionCard extends StatelessWidget {
  final spinkit = SpinKitPulse(
    color: Colors.lightGreen.withOpacity(0.8),
    size: 50.0,
  );
  @override
  Widget build(BuildContext context) {
    dc = Get.put(DashboardController());
    return Obx(
      () => Visibility(
        visible: dc.image != null,
        child: Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Container(
            child: dc.submitting.value
                ? Column(children: [
                    Text(
                      'PREDICTING CROP HEALTH',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ).paddingOnly(top: 5, bottom: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (dc.image != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Image.file(
                                dc.image,
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          Column(
                            children: [
                              spinkit,
                              Text('predicting, please wait!')
                            ],
                          )
                        ]).paddingOnly(bottom: 20)
                  ])
                : Column(
                    children: [
                      Text(
                        'YOUR CROP HEALTH',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ).paddingOnly(top: 5, bottom: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (dc.image != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: Image.file(
                                  dc.image,
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            Column(
                              children: [
                                Text(
                                  dc.results.value == ''
                                      ? 'Enter a valid image'
                                      : 'Condition of ${dc.selected.value.title == 'Strawberry' ? 'crop' : dc.selected.value.title} is',
                                  softWrap: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: dc.results.value
                                              .toLowerCase()
                                              .contains('healthy')
                                          ? Colors.green
                                          : Colors.redAccent),
                                ),
                                if (dc.results.value != '')
                                  Text(
                                    dc.results.value,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: dc.results.value
                                                .toLowerCase()
                                                .contains('healthy')
                                            ? Colors.green
                                            : Colors.redAccent),
                                  ).paddingOnly(bottom: 10),
                                if (!dc.results.value
                                        .toLowerCase()
                                        .contains('healthy') &&
                                    dc.results.value != '')
                                  OutlinedButton.icon(
                                    style: ButtonStyle(overlayColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((states) {
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return Colors.deepOrangeAccent
                                            .withOpacity(0.4);
                                      }
                                      return Colors.transparent;
                                    })),
                                    onPressed: () {},
                                    icon: Icon(FlutterIcons.healing_mdi,
                                        color: Colors.deepOrangeAccent),
                                    label: Text(
                                      'Get Remedies',
                                      style: TextStyle(
                                          color: Colors.deepOrangeAccent),
                                    ),
                                  ),
                              ],
                            ),
                          ]).paddingOnly(bottom: 20)
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class CenterCard extends StatelessWidget {
  const CenterCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                        size: 30, color: Colors.deepOrangeAccent),
                    Text(
                      'See Diagnosis',
                      style: TextStyle(
                          fontSize: 12, color: Colors.deepOrangeAccent),
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
                // Get.toNamed('/camera');
                dc.generateDialog(false);
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
              onPressed: () => dc.generateDialog(true),
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
    );
  }
}

class CropsAnimatedList extends StatelessWidget {
  const CropsAnimatedList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.isDarkMode ? Get.theme.scaffoldBackgroundColor : Colors.white,
      height: 100,
      child: Stack(
        children: [
          ListView.builder(
            physics: BouncingScrollPhysics(),
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
                              'Diagnose ${dc.selected.value.title}',
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
                onTap: () {
                  dc.selected.value = crop;
                  dc.image = null;
                },
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
                          height: 10.14,
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
