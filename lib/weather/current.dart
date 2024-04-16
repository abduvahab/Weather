import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './hours.dart';
import 'dart:convert';


// https://api.open-meteo.com/v1/forecast
// ?latitude=52.52&longitude=13.41&current=temperature_2m,apparent_temperature,precipitation,weather_code,wind_speed_10m
// latitude: 48.32, longitude: 3.1999998, generationtime_ms:
// 0.047087669372558594, utc_offset_seconds: 0, timezone: GMT,
// timezone_abbreviation: GMT, elevation: 67, current_units: {time: iso8601,
// interval: seconds, temperature_2m: °C, precipitation: mm, rain: mm, showers:
// mm, snowfall: cm, cloud_cover: %, wind_speed_10m: km/h}, current: {time:
// 2024-03-29T15:15, interval: 900, temperature_2m: 11.9, precipitation: 0.1,
// rain: 0, showers: 0, snowfall: 0, cloud_cover: 100, wind_speed_10m: 11.6}}


// https://api.open-meteo.com/v1/forecast?
// latitude=52.52&longitude=13.41&
// hourly=temperature_2m,precipitation,rain,showers,snowfall,cloud_cover,cloud_cover_low,cloud_cover_mid,cloud_cover_high,visibility,wind_speed_10m
// forecast_days=1



Future<CurrentWeather> getCurrentWeather(String latitude, String longitude)async{
  debugPrint('$latitude $longitude');
  const String url = "https://api.open-meteo.com/v1/forecast";
  const String current = "weather_code,apparent_temperature,precipitation,rain,showers,snowfall,cloud_cover,wind_speed_10m";
  final response = await http.get(Uri.parse('$url?latitude=$latitude&longitude=$longitude&current=$current'));
  
  if(response.statusCode == 200){
    Map<String, dynamic> jsondata = json.decode(response.body);
    // debugPrint("current--------");
    // debugPrint(jsondata.toString());
    if(jsondata["current"] != null){
      CurrentWeather current = CurrentWeather.fromJson(jsondata["current"]);
      current.determineWeather();
      return current;
    }else{
      throw Exception("Error: get current weather info failed");
    }
    // debugPrint(jsondata.toString());
  }else{
    throw Exception("Error: get current weather info failed");
  }

}




// {latitude: 47.760002, longitude: 7.319999, generationtime_ms:
// 0.5429983139038086, utc_offset_seconds: 0, timezone: GMT,
// timezone_abbreviation: GMT, elevation: 239, current_units: {time: iso8601,
// interval: seconds, temperature_2m: °C, precipitation: mm, rain: mm, showers:
// mm, snowfall: cm, cloud_cover: %, wind_speed_10m: km/h}, current: {time:
// 2024-03-30T05:30, interval: 900, temperature_2m: 8.8, precipitation: 0,
// rain: 0, showers: 0, snowfall: 0, cloud_cover: 100, wind_speed_10m: 4.7}}


class CurrentWeather{
  final String  time;
  final int     interval;
  final int     weather_code;
  final int     cloud_cover;
  final double  apparent_temperature;
  final double  precipitation;
  final double  wind_speed_10m;
  final double  rain;
  final double  showers;
  final double  snowfall;
  String  Condition='';
  String    path='';

  CurrentWeather({
    required this.cloud_cover,
    required this.weather_code,
    required this.interval ,
    required this.precipitation ,
    required this.rain ,
    required this.showers ,
    required this.snowfall ,
    required this.apparent_temperature ,
    required this.time ,
    required this.wind_speed_10m ,
  });

void determineWeather(){
  WeatherIcon icon_condition= weatherCodeInterprtation(weather_code);
  Condition = icon_condition.condition;
  path = icon_condition.path;
  // if (precipitation > 0){
  //   if(snowfall > 0){
  //     condition ='Snow';
  //   }
  //   else if(rain > 0){
  //     condition ='Rain';
  //   }
  //   else{
  //     condition ='Showers';
  //   }
  // }else
  // {
  //   if(cloud_cover > 10 && cloud_cover < 80){
  //     condition ='PartlyCloudy';
  //   }
  //   else if(cloud_cover >= 80){
  //     condition ='Cloudy';
  //   }
  //   else{
  //     condition ='Sunny';
  //   }
  // }

  // return condition;
  // return condition;
}

  factory CurrentWeather.fromJson(Map<String, dynamic> json){
    return CurrentWeather(
            cloud_cover: json['cloud_cover'], 
            weather_code: json['weather_code'], 
            interval: json['interval'], 
            precipitation: json['precipitation'], 
            rain: json['rain'], 
            showers: json['showers'], 
            snowfall: json['snowfall'], 
            apparent_temperature: json['apparent_temperature'], 
            time: json['time'], 
            wind_speed_10m: json['wind_speed_10m']
    );
  }
}