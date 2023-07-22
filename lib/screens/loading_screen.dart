import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  void getLocationWeather() async {
    var weatherdata = await WeatherModel().getLocationWeather();

    if (mounted) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LocationScreen(weatherData: weatherdata)));
    }
  }

  @override
  void initState() {
    getLocationWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
