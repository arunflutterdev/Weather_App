import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/weather_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherService{
  static const BASE_URL='http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;
  WeatherService(this.apiKey);
  Future<Weather>getWeather(String cityName)async{
    final response =await http
    .get(Uri.parse('$BASE_URL?q=$cityName &appid=$apiKey&units=metric'));
    print(response);
    if(response.statusCode==200){
      return Weather.fromJson(jsonDecode(response.body));

    }else{
      throw Exception('failed to load weather');
    }
  }

  Future<String> getCurrentCity() async{
    //get permission from user
    LocationPermission permission=await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();

    }
    //Fetch current location
    Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // convert location into place mark
    List<Placemark>placemark=await placemarkFromCoordinates(position.latitude,position.longitude);

    //city name from first placemark
    String? city=placemark[0].locality;
    return city ?? ""; 


  }
}