
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './hours.dart';

// https://api.open-meteo.com/v1/forecast?
// latitude=52.52&longitude=13.41&daily=temperature_2m_max
// , temperature_2m_min,uv_index_clear_sky_max,precipitation_sum
// ,rain_sum,showers_sum,snowfall_sum

// {latitude: 47.760002, longitude: 7.319999, generationtime_ms:
// 0.2690553665161133, utc_offset_seconds: 0, timezone: GMT, timezone_abbreviation:
// GMT, elevation: 239, daily_units: {time: iso8601, weather_code: wmo code,
// apparent_temperature_max: °C, apparent_temperature_min: °C, precipitation_sum:
// mm, rain_sum: mm, showers_sum: mm, snowfall_sum: cm}, daily: {time: [2024-04-01,
// 2024-04-02, 2024-04-03, 2024-04-04, 2024-04-05, 2024-04-06, 2024-04-07],
// weather_code: [80, 80, 61, 3, 3, 3, 61], apparent_temperature_max: [10.3, 9.9,
// 11, 16.4, 21.2, 27.7, 19.3], apparent_temperature_min: [2.9, 4.4, 6.8, 7.7, 7.8,
// 6.9, 13.1], precipitation_sum: [12.1, 0.1, 2.7, 0, 0, 0, 4.7], rain_sum: [11.5,
// 0, 3.6, 0, 0, 0, 4.7], showers_sum: [0.7, 0, 0.2, 0, 0, 0, 0], snowfall_sum: [0,
// 0, 0, 0, 0, 0, 0]}}


Future<Week> getWeeklyWeather(String latitude, String longitude)async{
  debugPrint('$latitude $longitude');
  const String url = "https://api.open-meteo.com/v1/forecast";
  const String daily ="weather_code,apparent_temperature_max,apparent_temperature_min";
  final response = await http.get(Uri.parse('$url?latitude=$latitude&longitude=$longitude&daily=$daily'));
  if(response.statusCode == 200){
    Map<String, dynamic> jsondata = json.decode(response.body);
    // debugPrint("Daily--------");
    // debugPrint(jsondata.toString());
    if(jsondata["daily"] != null){
      Week daily = Week.fromJson(jsondata["daily"]);
      daily.determineWeather();
      daily.timeFormat();
      return daily;
    }else{
      throw Exception("Error: get hourly weather info failed");
    }
    // debugPrint(jsondata.toString());
  }else{
    throw Exception("Error: get current weather info failed");
  }

}


class Week{
  List<String>  time;
  final List<int>     weather_code;
  final List<double>  apparent_temperature_max;
  final List<double>  apparent_temperature_min;
  List<String>        conditions=[];
  List<IconData>        icons=[];
  
  Week({
    required this.apparent_temperature_max,
    required this.apparent_temperature_min,
    required this.time,
    required this.weather_code,
  });

  void determineWeather(){
    for (var i=0; i<7; i++){
      WeatherIcon ics =  weatherCodeInterprtation(weather_code[i]);
      conditions.add(ics.condition);
      icons.add(ics.icon);
      // conditions.add(weatherCodeInterprtation(weather_code[i]).condition);
    }
  }

  void timeFormat(){
    List<String> temp=[];
    for (var i=0; i< time.length;i++){
            List<String>  cut= time[i].split('-');
            temp.add('${cut[2]}/${cut[1]}');
    }
    time = temp;
  }

  factory Week.fromJson(Map<String, dynamic> json){
    return Week(
      time:List<String>.from(json['time'].map((element){return element as String;})),
      weather_code:List<int>.from(json['weather_code'].map((element){return element as int;})),
      apparent_temperature_max:List<double>.from(json['apparent_temperature_max'].map((element){return element as double;})),
      apparent_temperature_min:List<double>.from(json['apparent_temperature_min'].map((element){return element as double;})),
    );
  }
}