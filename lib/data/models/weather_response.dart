import 'dart:convert';

class WeatherResponse {
  final Map<String, dynamic> data;

  WeatherResponse(this.data);

  factory WeatherResponse.fromJson(String json) {
    Map<String, dynamic> data = jsonDecode(json);
    return WeatherResponse(data);
  }

  List<Weather> get weathers {
    return data.values.map((e) {
      return Weather.fromJson(e);
    }).toList();
  }
}

class Weather {
  final String time;
  final double t_2m__min;
  final double t_2m__max;
  final double asob_s__sum;
  final double tot_prec__sum;
  final double h_snow__sum;
  final double relhum_2m__avg;
  final double u_10m__avg;
  final double v_10m__avg;
  final double w_speed__avg;
  final double clct__avg;
  final double td_2m__avg;
  final double t_so__min;
  final double t_so__max;
  final double ps__avg;
  final double w_dir__avg;
  final int ww;
  final String ww_human;

  Weather({
    this.time = '',
    this.t_2m__min = 0,
    this.t_2m__max = 0,
    this.asob_s__sum = 0,
    this.tot_prec__sum = 0,
    this.h_snow__sum = 0,
    this.relhum_2m__avg = 0,
    this.u_10m__avg = 0,
    this.v_10m__avg = 0,
    this.w_speed__avg = 0,
    this.clct__avg = 0,
    this.td_2m__avg = 0,
    this.t_so__min = 0,
    this.t_so__max = 0,
    this.ps__avg = 0,
    this.w_dir__avg = 0,
    this.ww = 0,
    this.ww_human = '',
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      time: json['time'],
      t_2m__min: json['t_2m__min'],
      t_2m__max: json['t_2m__max'],
      asob_s__sum: json['asob_s__sum'],
      tot_prec__sum: json['tot_prec__sum'],
      h_snow__sum: json['h_snow__sum'],
      relhum_2m__avg: json['relhum_2m__avg'],
      u_10m__avg: json['u_10m__avg'],
      v_10m__avg: json['v_10m__avg'],
      w_speed__avg: json['w_speed__avg'],
      clct__avg: json['clct__avg'],
      td_2m__avg: json['td_2m__avg'],
      t_so__min: json['t_so__min'],
      t_so__max: json['t_so__max'],
      ps__avg: json['ps__avg'],
      w_dir__avg: json['w_dir__avg'],
      ww: json['ww'],
      ww_human: json['ww_human'],
    );
  }
}
