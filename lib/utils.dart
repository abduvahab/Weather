
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';//for get city info according to coordinate
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';//get current location
import 'dart:convert';
import 'dart:async';
import './weather/current.dart';
import './weather/hours.dart';
import './weather/days.dart';


Future<Position> getCurrentPosition()async{

  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if(!serviceEnabled){
    throw Exception('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if(permission == LocationPermission.denied){
    permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.denied){
      throw Exception("Location permission request denied");

    }
  }
  if(permission == LocationPermission.deniedForever){
    throw Exception("Location permission request denied forever");
  }
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.best,
  );
  
  return position;

}


Future<Address> getCityInfo(Position position)async{
  GeoCode geoCode = GeoCode();
  Address addr = await geoCode.reverseGeocoding(latitude:position.latitude, longitude:position.longitude);
  // debugPrint(addr.toString());
  if(addr.countryName != null){
    // debugPrint(addr.city);
    return addr;
  }else{
    throw Exception("Error: problem getting city information");
  }
  
}

class CityToDisplay{
  String name;
  double latitude;
  double longitude;
  String country;
  String admin1;
  String timezone;
  late CurrentWeather current;
  late HourlyWeather hourly;
  late Week week;
  late Image    icon;

  CityToDisplay({
    required this.admin1,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.timezone,
  });
}


// Define a class to represent the structure of each city
class City {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final double elevation;
  final String featureCode;
  final String countryCode;
  final int admin1Id;
  final int admin2Id;
  final int admin3Id;
  final int admin4Id;
  final String timezone;
  final int population;
  final List<String> postcodes;
  final int countryId;
  final String country;
  final String admin1;
  final String admin2;
  final String admin3;
  final String admin4;

  City({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.elevation,
    required this.featureCode,
    required this.countryCode,
    required this.admin1Id,
    required this.admin2Id,
    required this.admin3Id,
    required this.admin4Id,
    required this.timezone,
    required this.population,
    required this.postcodes,
    required this.countryId,
    required this.country,
    required this.admin1,
    required this.admin2,
    required this.admin3,
    required this.admin4,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
      elevation: json['elevation'] ?? 0.0,
      featureCode: json['feature_code'] ?? "",
      countryCode: json['country_code'] ?? "",
      admin1Id: json['admin1_id'] ?? 0,
      admin2Id: json['admin2_id'] ?? 0,
      admin3Id: json['admin3_id'] ?? 0,
      admin4Id: json['admin4_id'] ?? 0,
      timezone: json['timezone'] ?? "",
      population: json['population'] ?? 0,
      postcodes: List<String>.from(json['postcodes'] ?? []),
      countryId: json['country_id'] ?? 0,
      country: json['country'] ?? "",
      admin1: json['admin1'] ?? "",
      admin2: json['admin2'] ?? "",
      admin3: json['admin3'] ?? "",
      admin4: json['admin4'] ?? "",
    );
  }
}

// https://geocoding-api.open-meteo.com/v1/search?name=Berlin&count=10&language=en&format=json
Future<List<City>> getCityListByName(String name)async{
    List<City> list=[];
    const apiUrl = 'https://geocoding-api.open-meteo.com/v1/search';
    final reponse = await http.get(Uri.parse('$apiUrl?name=$name'));
    if(reponse.statusCode == 200){
      Map<String, dynamic> jsondata = json.decode(reponse.body);
      if(jsondata["results"] != null){
        list = List<City>.from(jsondata["results"].map((city)=>City.fromJson(city)));
      }
      return list;
    }
    else{
      throw Exception('Failed to load data: ${reponse.statusCode}');
    }
    
}





