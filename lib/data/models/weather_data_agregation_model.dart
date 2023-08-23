class WeatherDataAgregationModel {
  String date;
  double tempAirMin;
  double tempAirMax;
  double tempLandMin;
  double tempLandMax;
  double relHumidity;
  double snowDepth;
  Rain rain;
  WindSpeed windSpeed;

  WeatherDataAgregationModel({
    required this.date,
    required this.tempAirMin,
    required this.tempAirMax,
    required this.tempLandMin,
    required this.tempLandMax,
    required this.relHumidity,
    required this.snowDepth,
    required this.rain,
    required this.windSpeed,
  });

  factory WeatherDataAgregationModel.fromJson(Map<String, dynamic> json) {
    return WeatherDataAgregationModel(
      date: json['Date'],
      tempAirMin: json['Temp_air_min'],
      tempAirMax: json['Temp_air_max'],
      tempLandMin: json['Temp_land_min'],
      tempLandMax: json['Temp_land_max'],
      relHumidity: json['Rel_humidity'],
      snowDepth: json['Snow_depth'],
      rain: Rain.fromJson(json['Rain']),
      windSpeed: WindSpeed.fromJson(json['Windspeed']),
    );
  }
}

class Rain {
  double h02;
  double h05;
  double h08;
  double h11;
  double h14;
  double h17;
  double h20;
  double h23;

  Rain({
    required this.h02,
    required this.h05,
    required this.h08,
    required this.h11,
    required this.h14,
    required this.h17,
    required this.h20,
    required this.h23,
  });

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(
      h02: json['02h'],
      h05: json['05h'],
      h08: json['08h'],
      h11: json['11h'],
      h14: json['14h'],
      h17: json['17h'],
      h20: json['20h'],
      h23: json['23h'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '02h': h02,
      '05h': h05,
      '08h': h08,
      '11h': h11,
      '14h': h14,
      '17h': h17,
      '20h': h20,
      '23h': h23,
    };
  }
}

class WindSpeed {
  double h02;
  double h05;
  double h08;
  double h11;
  double h14;
  double h17;
  double h20;
  double h23;

  WindSpeed({
    required this.h02,
    required this.h05,
    required this.h08,
    required this.h11,
    required this.h14,
    required this.h17,
    required this.h20,
    required this.h23,
  });

  factory WindSpeed.fromJson(Map<String, dynamic> json) {
    return WindSpeed(
      h02: json['02h'],
      h05: json['05h'],
      h08: json['08h'],
      h11: json['11h'],
      h14: json['14h'],
      h17: json['17h'],
      h20: json['20h'],
      h23: json['23h'],
    );
  }
}
