import 'package:flutter/material.dart';
import 'package:flutter_app_json_http/weather_forecast/model/weather_forecast_model.dart';
import 'package:flutter_app_json_http/weather_forecast/util/convert_icon.dart';
import 'package:flutter_app_json_http/weather_forecast/util/forecast_util.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MidView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecastModel> snapshot;


  const MidView({Key key, this.snapshot}) : super(key: key);@override
  Widget build(BuildContext context) {

    var forecastList = snapshot.data.list;
    var city = snapshot.data.city.name;
    var country  = snapshot.data.city.country;
    var formattedDate= new DateTime.fromMillisecondsSinceEpoch(forecastList[0].dt*1000);
    var forecast = forecastList[0];
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('$city,$country',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87
              ),),

            Text('${Util.getFormattedDate(formattedDate)}', style: TextStyle(
                fontSize: 15.0
            ),),
            SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: getWeatherIcon(weatherDescription: forecastList[0].weather[0].main,color:Colors.pinkAccent,size: 198),
            ),
            //Icon(FontAwesomeIcons.cloud, size: 198 , color: Colors.pinkAccent),
            //Icon(Icons.wb_sunny,size: 195),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text('Forecasting ${forecastList[0].temp.day.toStringAsFixed(0)}°F',style: TextStyle(fontSize: 20),)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text('${forecast.weather[0].description.toUpperCase()}')),
                  ),



                ],

              ),

            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical : 12.0, horizontal: 12.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center\,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Center(child: Text('${forecast.speed.toStringAsFixed(1)} mi/h')),
                            //Icon(Icons.arrow_forward,size:20, color: Colors.brown),
                            Center(child: Icon(FontAwesomeIcons.temperatureHigh,size: 20,)),


                          ],
                        ),
                      ),
                      Center(
                        child: Padding(

                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text('${forecast.humidity.toStringAsFixed(0)} %'),
                              Icon(FontAwesomeIcons.solidGrinBeamSweat, size: 20 , color: Colors.pinkAccent),
                              //Icon(Icons.hot_tub,size:20, color: Colors.brown),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(padding: EdgeInsets.all(8.0),
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${forecast.temp.max.toStringAsFixed(0)}°F'),
                              Icon(FontAwesomeIcons.temperatureHigh, size: 20 , color: Colors.brown),
                              //Icon(FontAwesomeIcons.cloud, size: 198 , color: Colors.pinkAccent),
                              //Icon(Icons.wb_sunny,size: 20, color: Colors.brown),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}




Widget midView(AsyncSnapshot<WeatherForecastModel> snapshot){
  var forecastList = snapshot.data.list;
  var city = snapshot.data.city.name;
  var country  = snapshot.data.city.country;
  var formattedDate= new DateTime.fromMillisecondsSinceEpoch(forecastList[0].dt*1000);
  var forecast = forecastList[0];

    Container midView = Container(
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$city,$country',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black87
          ),),

        Text('${Util.getFormattedDate(formattedDate)}', style: TextStyle(
          fontSize: 15.0
        ),),
        SizedBox(height: 10.0,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: getWeatherIcon(weatherDescription: forecastList[0].weather[0].main,color:Colors.pinkAccent,size: 198),
          ),
          //Icon(FontAwesomeIcons.cloud, size: 198 , color: Colors.pinkAccent),
          //Icon(Icons.wb_sunny,size: 195),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Forecasting ${forecastList[0].temp.day.toStringAsFixed(0)}°F\n',style: TextStyle(fontSize: 34),),
                Text('${forecast.weather[0].description.toUpperCase()}'),



              ],

            ),

          ),
          Center(

            child: Padding(
              padding: const EdgeInsets.symmetric(vertical : 12.0, horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('${forecast.speed.toStringAsFixed(1)} mi/h'),
                        //Icon(Icons.arrow_forward,size:20, color: Colors.brown),
                        Icon(FontAwesomeIcons.temperatureHigh,size: 20,),


                      ],
                    ),
                  ),
                  Padding(

                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('${forecast.humidity.toStringAsFixed(0)} %'),
                        Icon(FontAwesomeIcons.solidGrinBeamSweat, size: 20 , color: Colors.pinkAccent),
                        //Icon(Icons.hot_tub,size:20, color: Colors.brown),
                      ],
                    ),
                  ),
                Padding(padding: EdgeInsets.all(8.0),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${forecast.temp.max.toStringAsFixed(0)}°F'),
                    Icon(FontAwesomeIcons.temperatureHigh, size: 20 , color: Colors.brown),
                    //Icon(FontAwesomeIcons.cloud, size: 198 , color: Colors.pinkAccent),
                    //Icon(Icons.wb_sunny,size: 20, color: Colors.brown),

                  ],
                ),
                ),
                ],
              ),
            ),
          ),


        ],
      ),
    ),
  );

}