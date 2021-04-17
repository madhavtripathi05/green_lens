import 'package:flutter/material.dart';
import 'package:green_lens/app/models/weather.dart';
import 'forecast_horizontal_widget.dart';
import 'value_tile.dart';
import 'weather_swipe_pager.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  WeatherWidget({this.weather}) : assert(weather != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            this.weather.cityName.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: 5,
                color: Get.theme.primaryColor,
                fontSize: 25),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            this.weather.description.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.w100,
                letterSpacing: 5,
                fontSize: 15,
                color: Get.theme.primaryColor),
          ),
          WeatherSwipePager(weather: weather),
          Padding(
            child: Divider(
              color: Get.theme.primaryColor.withAlpha(50),
            ),
            padding: EdgeInsets.all(10),
          ),
          ForecastHorizontal(weathers: weather.forecast),
          Padding(
            child: Divider(
              color: Get.theme.primaryColor.withAlpha(50),
            ),
            padding: EdgeInsets.all(10),
          ),
          Container(
            height: 50,
            width: Get.width,
            child:
                ListView(scrollDirection: Axis.horizontal, children: <Widget>[
              ValueTile("wind speed", '${this.weather.windSpeed} m/s'),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Center(
                    child: Container(
                  width: 1,
                  height: 30,
                  color: Get.theme.primaryColor.withAlpha(50),
                )),
              ),
              ValueTile(
                  "sunrise",
                  DateFormat('h:m a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          this.weather.sunrise * 1000))),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Center(
                    child: Container(
                  width: 1,
                  height: 30,
                  color: Get.theme.primaryColor.withAlpha(50),
                )),
              ),
              ValueTile(
                  "sunset",
                  DateFormat('h:m a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          this.weather.sunset * 1000))),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Center(
                    child: Container(
                  width: 1,
                  height: 30,
                  color: Get.theme.primaryColor.withAlpha(50),
                )),
              ),
              ValueTile("humidity", '${this.weather.humidity}%'),
            ]),
          ),
        ],
      ),
    );
  }
}
