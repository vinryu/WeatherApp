import 'package:flutter/material.dart';
import 'package:flutter_app_json_http/weather_forecast/model/weather_forecast_model.dart';
import 'package:flutter_app_json_http/weather_forecast/ui/bottom_view.dart';
import 'package:flutter_app_json_http/weather_forecast/ui/mid_view.dart';

import 'network/network.dart';

class WeatherForecast extends StatefulWidget {
  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  Future<WeatherForecastModel> forecastObject;
  String _cityName = "Portland";

  @override
  void initState() {
    // TODO: implement initState
      super.initState();
      forecastObject = getWeather(cityName: _cityName);
      // forecastObject.then((weather) => {
      //   print(weather.city);
      //     print(weather.list[0].weather[0].main);
      // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Forecast'),
      //   centerTitle: true ,
      //
      // ),
      body: ListView(
        children: [
          textFieldsView(),
          Text('hi'),
          Container(

          child:
            FutureBuilder<WeatherForecastModel>(
              future: forecastObject,
              builder: (BuildContext context, AsyncSnapshot<WeatherForecastModel> snapshot){
                if(snapshot.hasData){
                  return Column(
                    children: [
                      MidView(snapshot: snapshot,),
                      //midView(snapshot),
                      //bottomView(snapshot, context),
                      BottomView(snapshot: snapshot,),
                    ],
                  );
                } else{
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget textFieldsView() {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Enter City Name',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),),
          contentPadding: EdgeInsets.all(8.0),
        ),
          onSubmitted: (value){
           setState(() {
             _cityName = value;
             forecastObject = getWeather(cityName: _cityName);

           });

          },
      ),
    );
  }

  Future<WeatherForecastModel> getWeather({String cityName}) => Network().getWeatherForecast(cityName: _cityName);
}
