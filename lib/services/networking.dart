import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_app/services/location.dart';

import '../utilities/constants.dart';

const apiKey = kApiKey;

class NetworkHelper {
  Future<dynamic> getData(Location location) async {
    Response response = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.lat}&lon=${location.long}&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  }

  Future<dynamic> getDataByCityName(String city) async {
    Response response = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  }
}
