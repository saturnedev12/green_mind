import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenmind/configs/constants.dart';
import 'package:greenmind/data/models/weather_data_agregation_model.dart';

class WeatherSmallBox extends StatelessWidget {
  const WeatherSmallBox({super.key, required this.weatherDataAgregationModel});
  final WeatherDataAgregationModel weatherDataAgregationModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go(
        '/weatherDetail',
        extra: weatherDataAgregationModel,
      ),
      child: Container(
        width: 330,
        height: 220,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              spreadRadius: 2,
              color: Colors.grey[500]!,
            ),
          ],
          gradient: LinearGradient(
            colors: [
              HexColor.fromHex("#523D7F"),
              HexColor.fromHex("#957DCD"),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/weather/sun_cloud.png',
                  width: 110,
                ),
                Container(
                  width: 150,
                  height: 100,
                  //color: Colors.green,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Text(
                          "${weatherDataAgregationModel.tempAirMax.toInt()}˚",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 65,
                        bottom: 20,
                        child: Text(
                          '/',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 50,
                              color: Colors.white),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 4,
                        child: Text(
                          "${weatherDataAgregationModel.tempAirMin.toInt()}˚",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherPuceIndicator(
                  imagePath: 'assets/images/weather/umbrella.png',
                  title: '${weatherDataAgregationModel.rain.h14.toInt()}%',
                  subTitle: 'Precipitation',
                ),
                WeatherPuceIndicator(
                  imagePath: 'assets/images/weather/drop.png',
                  title: '${weatherDataAgregationModel.relHumidity.toInt()}%',
                  subTitle: 'Humidité',
                ),
                WeatherPuceIndicator(
                  imagePath: 'assets/images/weather/wind.png',
                  title:
                      '${weatherDataAgregationModel.windSpeed.h14.toInt()}km/h',
                  subTitle: 'Wind Speed',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class WeatherPuceIndicator extends StatelessWidget {
  const WeatherPuceIndicator({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
  });
  final String imagePath;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 30,
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            subTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}
