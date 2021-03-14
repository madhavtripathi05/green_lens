import 'dart:convert';
import '../models/weather.dart';
import 'package:http/http.dart' as http;

/// Wrapper around the open weather map api
/// https://openweathermap.org/current
class WeatherApi {
  static const baseUrl = 'http://api.openweathermap.org';
  final apiKey = 'd5501bd4efb1d7d35347fd5578074b1c';

  Future<String> getCityNameFromLocation(
      {double latitude, double longitude}) async {
    final url =
        '$baseUrl/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey';
    print('fetching $url');
    final res = await http.get(Uri.parse(url));
    print('city: ${res.body}');
    if (res.statusCode != 200) {
      print("unable to fetch weather data");
    }
    final weatherJson = json.decode(res.body);
    return weatherJson['name'];
  }

  Future<Weather> getWeatherData(String cityName) async {
    final url = '$baseUrl/data/2.5/weather?q=$cityName&appid=$apiKey';
    print('fetching $url');
    final res = await http.get(Uri.parse(url));
    if (res.statusCode != 200) {
      print("unable to fetch weather data");
    }
    final weatherJson = json.decode(res.body);
    return Weather.fromJson(weatherJson);
  }

  Future<List<Weather>> getForecast(String cityName) async {
    final url = '$baseUrl/data/2.5/forecast?q=$cityName&appid=$apiKey';
    print('fetching $url');
    final res = await http.get(Uri.parse(url));
    if (res.statusCode != 200) {
      print("unable to fetch weather data");
    }
    final forecastJson = json.decode(res.body);
    List<Weather> weathers = Weather.fromForecastJson(forecastJson);
    return weathers;
  }
}
