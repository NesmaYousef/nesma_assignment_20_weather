import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/weather.dart';
import '../utilities/constants.dart';
import '../widgets/customTextButton.dart';

class LocationScreen extends StatefulWidget {
  final weatherData;
  const LocationScreen({super.key, this.weatherData});

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  ImageProvider networkImage =
      const NetworkImage('https://source.unsplash.com/random/?cloud');

  ImageProvider assetImage = const AssetImage('images/location_background.jpg');

  bool isLoaded = false;

  WeatherModel weather = WeatherModel();

  num temp = 0;
  int condition = 0;
  String description = 'there is no weather data';
  late String cityName = '';
  late String icon = 'Error';

  void updateUi(var wData) {
    setState(() {
      if (wData != null) {
        temp = wData['main']['temp'];
        condition = wData['weather'][0]['id'];
        cityName = wData['name'];
        description = weather.getMessage(temp.toInt());
        icon = weather.getWeatherIcon(condition);
      }
    });
  }

  @override
  void initState() {
    networkImage
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((image, synchronousCall) {
      setState(() {
        isLoaded = true;
      });
    }));

    updateUi(widget.weatherData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: isLoaded ? networkImage : assetImage,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8), BlendMode.dstATop),
              ),
            ),
            constraints: const BoxConstraints.expand(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white.withOpacity(0.0),
                    Colors.white.withOpacity(0.0)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  // color: Colors.white.withOpacity(0.0),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    customTextButton(
                      icon: Icons.near_me,
                      func: () {
                        updateUi(widget.weatherData);
                      },
                    ),
                    customTextButton(
                      icon: Icons.location_city,
                      func: () async {
                        var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CityScreen(),
                          ),
                        );
                        updateUi(result);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$icon',
                      style: kTempTextStyle,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '${temp.round()}',
                          style: kTempTextStyle,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 10),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 7,
                              width: 35,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                                  // shape: BoxShape.circle,
                                  ),
                            ),
                            const Text(
                              'now',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontFamily: 'Spartan MB',
                                letterSpacing: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 24.0, bottom: 24),
                child: Text(
                  '$description in $cityName',
                  textAlign: TextAlign.left,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
