import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:greenmind/data/models/weather_data_agregation_model.dart';

class WeatherRepository {
  Dio _dio = Dio();
  final String key = dotenv.env['API_KEY']!;
  final String host = dotenv.env['HOST']!;
  getWeatherBetween() async {
    // Parse la réponse JSON et crée un tableau de WeatherData
    List<WeatherDataAgregationModel> _parseWeatherData(List<dynamic> response) {
      return response
          .map<WeatherDataAgregationModel>(
              (json) => WeatherDataAgregationModel.fromJson(json))
          .toList();
    }

    Future<List<WeatherDataAgregationModel>> getWeatherBetween(
        /*{required String dateFrom, required String dateTo}*/) async {
      // Create a Dio instance

      // Define the request URL
      String url = '$host/api/forecast/weather/forecast/?api_key=$key';

      // Define the request body
      var body = jsonEncode({
        "geometry": {
          "type": "Polygon",
          "coordinates": [
            [
              [29.659867, 49.596693],
              [29.658108, 49.591491],
              [29.667463, 49.590072],
              [29.669137, 49.595135],
              [29.659867, 49.596693]
            ]
          ]
        },
      });

      // Make the POST request
      Response response = await _dio.post(
        url,
        data: body,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );
      inspect(response);
      // Check the response status code

      // The request was successful
      return _parseWeatherData(response.data);
    }
  }
}
