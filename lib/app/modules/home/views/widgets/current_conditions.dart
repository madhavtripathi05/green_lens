import 'package:flutter/material.dart';
import 'value_tile.dart';
import 'package:green_lens/app/models/weather.dart';
import 'package:get/get.dart';

/// Renders Weather Icon, current, min and max temperatures
class CurrentConditions extends StatelessWidget {
  final Weather weather;
  const CurrentConditions({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          weather.getIconData(),
          color: Get.theme.primaryColor,
          size: 70,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '${this.weather.temperature.celsius.round()}°C',
          style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.w100,
              color: Get.theme.primaryColor),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ValueTile("max", '${this.weather.maxTemperature.celsius.round()}°C'),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Center(
                child: Container(
              width: 1,
              height: 30,
              color: Get.theme.primaryColor.withAlpha(50),
            )),
          ),
          ValueTile("min", '${this.weather.minTemperature.celsius.round()}°C'),
        ]),
      ],
    );
  }
}
