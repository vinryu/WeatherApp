import 'package:flutter/material.dart';
import 'package:flutter_app_json_http/parsing_json/json_parsing.dart';
import 'package:flutter_app_json_http/parsing_json/json_parsing_map.dart';
import 'package:flutter_app_json_http/weather_forecast/weather_forecast.dart';//
//import 'package:url_launcher/url_launcher.dart';


void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: JsonParsingSimple(),
      // home: JsonParsingMap( ),//this is the list of all json data. use this
      home: WeatherForecast(),
      // home: JsonParsingSimple(),
    );
  }
}
