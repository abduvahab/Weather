
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_icons/weather_icons.dart';
// import '../asset/weather_icons/clear.';
// {latitude: 47.760002, longitude: 7.319999, generationtime_ms:
// 0.06401538848876953, utc_offset_seconds: 0, timezone: GMT,
// timezone_abbreviation: GMT, elevation: 239, hourly_units: {time: iso8601,
// temperature_2m: °C, precipitation: mm, rain: mm, showers: mm, snowfall: cm,
// cloud_cover: %, visibility: m, wind_speed_10m: km/h}, hourly: {time:
// [2024-03-30T00:00, 2024-03-30T01:00, 2024-03-30T02:00, 2024-03-30T03:00,
// 2024-03-30T04:00, 2024-03-30T05:00, 2024-03-30T06:00, 2024-03-30T07:00,
// 2024-03-30T08:00, 2024-03-30T09:00, 2024-03-30T10:00, 2024-03-30T11:00,
// 2024-03-30T12:00, 2024-03-30T13:00, 2024-03-30T14:00, 2024-03-30T15:00,
// 2024-03-30T16:00, 2024-03-30T17:00, 2024-03-30T18:00, 2024-03-30T19:00,
// 2024-03-30T20:00, 2024-03-30T21:00, 2024-03-30T22:00, 2024-03-30T23:00],
// temperature_2m: [9.7, 9.7, 9.5, 9.6, 9.4, 9.1, 9, 9.5, 10.3, 11.7, 14.4,
// 18.2, 18.1, 17.2, 16.8, 14.5, 13.9, 13.4, 13, 11.8, 11, 10.3, 10.1, 9.8],
// precipitation: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.2, 0.1, 0,
// 0, 1.6, 1.6, 0.9, 3.6], rain: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
// 0, 0, 0, 0, 0.2, 0.6, 0.1, 0.5, 4.2], showers: [0, 0, 0, 0, 0, 0, 0, 0, 0,
// 0, 0, 0, 0, 0, 0, 0.1, 0, 0, 0, 0.2, 0.3, 0.2, 0.2, 0], snowfall: [0, 0, 0,
// 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], cloud_cover:
// [100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 87, 96, 96, 100, 100, 85,
// 100, 100, 100, 100, 100, 100, 100, 100], visibility: [24140, 24140, 24140,
// 24140, 24140, 24140, 24140, 24140, 24140, 24140, 24140, 24140, 24140, 24140,
// 24140, 14820, 23500, 24140, 24140, 23460, 24140, 24140, 24140, 12800],
// wind_speed_10m: [5.1, 4.4, 1, 3.3, 4.3, 4.3, 6.1, 5.3, 5.1, 2.6, 8.3, 23,
// 22, 25.3, 22, 27.1, 19.4, 4.5, 5.5, 1.3, 9, 9.9, 8.2, 10.8]}}


Future<HourlyWeather> getHourlyWeather(String latitude, String longitude)async{
  debugPrint('$latitude $longitude');
  const String url = "https://api.open-meteo.com/v1/forecast";
  const String hourly ="weather_code,apparent_temperature,precipitation,rain,showers,snowfall,cloud_cover,wind_speed_10m";
  final response = await http.get(Uri.parse('$url?latitude=$latitude&longitude=$longitude&hourly=$hourly&forecast_days=1'));
  if(response.statusCode == 200){
    Map<String, dynamic> jsondata = json.decode(response.body);
    // debugPrint("hourly--------");
    // debugPrint(jsondata.toString());
    if(jsondata["hourly"] != null){
      // print(jsondata["hourly"].toString());
      HourlyWeather current = HourlyWeather.fromJson(jsondata["hourly"]);
      current.determineWeather();
      current.getHoursFormat();
      return current;
    }else{
      throw Exception("Error: get hourly weather info failed");
    }
    // debugPrint(jsondata.toString());
  }else{
    throw Exception("Error: get current weather info failed");
  }

}

class WeatherIcon{
  final String condition;
  final String path;
  final IconData icon;

  WeatherIcon({
    required this.condition,
    required this.path,
    required this.icon,
  });
}


WeatherIcon weatherCodeInterprtation(int code){
  // debugPrint('code');
  // debugPrint('$code');
  if (code == 0){
    // return "Sunny";
    return WeatherIcon(
      condition: "Sunny",
      path:'sunny.png',
      icon: WeatherIcons.day_sunny
      );
  }
  else if(code == 1 || code == 2 || code == 3){
    if(code == 1){
      return  WeatherIcon(
        condition: "Clear",
        path:'clear.png',
        icon: WeatherIcons.day_sunny
);
    }
    else if(code == 2){
      // return "Partly Cloudy";
      return  WeatherIcon(
        condition: "Partly Cloudy",
        path:'partly_cloudy.png',
        icon: WeatherIcons.day_cloudy_gusts
    );
    }
    else{
      // return "Overcast";
      return WeatherIcon(
        condition: "Overcast",
        path:'overcast.png',
        icon: WeatherIcons.day_cloudy_high
    );
    }
  }
  else if(code == 45 || code == 48 ){
    // return "Fog";
      return WeatherIcon(
        condition: "Fog",
        path:'fog.png',
        icon: WeatherIcons.fog
  );
  }
  else if(code == 61 || code == 63){
    if(code == 61){
      // return "Slight Rain";
      return WeatherIcon(
        condition: "Slight Rain",
        path:'Slight_Rain.png',
        icon: WeatherIcons.raindrop
    );
    }
    else{
      // return "Moderate Rain";
      return WeatherIcon(
        condition: "Moderate Rain",
        path:'moderate_rain.png',
        icon: WeatherIcons.raindrops
      );
    }
  }
  else if(code > 63 &&  code < 68){
    // return "Havey Rain";
      return WeatherIcon(
        condition: "Havey Rain",
        path:'rain.png',
        icon: WeatherIcons.day_rain
      );
  }
  else if(code >= 71 &&  code < 78){
    // return "Snow";
      return WeatherIcon(
        condition: "Snow",
        path:'snow.png',
        icon: WeatherIcons.snow
      );
  }
  else if(code > 79 &&  code < 83){
    // return "Shower";
      return WeatherIcon(
        condition: "Shower",
        path:'shower.png',
        icon: WeatherIcons.day_showers
      );
  }
  else if(code > 50 && code < 58){
    // return "Drizzle";
      return WeatherIcon(
        condition: "Drizzle",
        path:'drizzle.png',
        icon: WeatherIcons.day_rain_wind
      );
  }
  else if(code == 85 || code == 86 ){
    // return "Snow Shower";
      return WeatherIcon(
        condition: "Snow Shower",
        path:'snow_shower.png',
        icon: WeatherIcons.day_snow_thunderstorm
      );
  }
  else if(code == 95 || code == 96 || code == 99){
    // return "Thunderstorm";
      return WeatherIcon(
        condition: "Thunderstorm",
        path:'Thunderstorm.png',
        icon: WeatherIcons.day_thunderstorm
      );
  }
  else{
    throw Exception("Error: Wrong WMO code");
  }
}


class HourlyWeather{
  List<String>  time=[];
  List<String>  condition=[];
  List<IconData>  icons=[];
  // final List<int>    interval;
  final List<int>    cloud_cover;
  final List<int>    weather_code;
  final List<double>  apparent_temperature;
  final List<double>  precipitation;
  final List<double>  wind_speed_10m;
  final List<double>  rain;
  final List<double>  showers;
  final List<double>  snowfall;

   HourlyWeather({
    required this.cloud_cover,
    required this.weather_code,
    // required this.interval ,
    required this.precipitation ,
    required this.rain ,
    required this.showers ,
    required this.snowfall ,
    required this.apparent_temperature ,
    // required this.time ,
    required this.wind_speed_10m ,
  });

void getHoursFormat(){
  for (var i=0; i<24; i++){
    if(i < 10){
      time.add('0$i:00');
    }else{
      time.add('$i:00');
    }
  }
}

void determineWeather(){
  for(var i = 0 ; i < 24; i++){
    WeatherIcon ics =  weatherCodeInterprtation(weather_code[i]);
    condition.add(ics.condition);
    icons.add(ics.icon);
    // if (precipitation[i] > 0){
    //   if(snowfall[i] > 0){
    //     condition.add('Snow');
    //   }
    //   else if(rain[i] > 0){
    //     condition.add('Rain');
    //   }
    //   else{
    //     condition.add('Showers');
    //   }
    // }
    // else{
    //   if(cloud_cover[i] > 10 && cloud_cover[i] < 80){
    //     condition.add('PartlyCloudy');
    //   }
    //   else if(cloud_cover[i] >= 80){
    //     condition.add('Cloudy');
    //   }
    //   else{
    //     condition.add('Sunny');
    //   }
    // }
  }
}

  factory HourlyWeather.fromJson(Map<String, dynamic> json){
    return HourlyWeather(
            cloud_cover:List<int>.from( json['cloud_cover'].map((element){ return element as int;})), 
            weather_code:List<int>.from( json['weather_code'].map((element){ return element as int;})), 
            // interval:List<int>.from( json['interval'].map((element){ return element as int;})), 
            precipitation:List<double>.from( json['precipitation'].map((element){ return element as double;})), 
            rain:List<double>.from( json['rain'].map((element){ return element as double;})), 
            showers:List<double>.from( json['showers'].map((element){ return element as double;})), 
            snowfall:List<double>.from( json['snowfall'].map((element){ return element as double;})), 
            apparent_temperature:List<double>.from( json['apparent_temperature'].map((element){ return element as double;})), 
            wind_speed_10m:List<double>.from( json['wind_speed_10m'].map((element){ return element as double;})), 
            // time:List<String>.from( json['time'].map((element){ return element as String;})), 
            // time: json['time'], 
    );
  }
}