import 'dart:convert';

import 'package:flutter_app_json_http/weather_forecast/model/weather_forecast_model.dart';
import 'package:flutter_app_json_http/weather_forecast/util/forecast_util.dart';
import 'package:http/http.dart';

class Network {
  Future<WeatherForecastModel> getWeatherForecast({String cityName}) async {
   // var finalUrl  = 'https://api.openweathermap.org/data/2.5/forecast/daily?q=$cityName&appid=${Util.appId}&units=imperial';//change to metric or imperial
    var finalUrl  = 'https://api.openweathermap.org/data/2.5/forecast/daily?q=$cityName&appid=${Util.appId}&units=imperial';//change to metric or imperial
    //var finalUrl  = 'https://api.openweathermap.org/data/2.5/forecast/daily?q=portland&appid=ed60fcfbd110ee65c7150605ea8aceea&units=imperial';
    final response = await get(Uri.encodeFull(finalUrl));
    print('URL : ${Uri.encodeFull(finalUrl)}');

    if(response.statusCode == 200){

      print('weather data : ${response.body}');
      return WeatherForecastModel.fromJson(json.decode(response.body));// now we get the actual mapped model (dart object)



    } else {
      throw Exception('Error getting weather forecast');
    }

  }
}