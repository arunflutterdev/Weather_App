import 'package:flutter/material.dart';
import 'package:flutter_application_1/wearher_services.dart';
import 'package:flutter_application_1/weather_model.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //apikey
  final _weatherService = WeatherService('ApiKey');
  Weather? _weather;

  //fetch Wearher
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather=weather;
      });
    } catch (e) {
      print(e);
    }
  }

//weather animation
String getWeatherAnimation(String?mainCondition){
  if (mainCondition==null) return 'assets/sunny.json';
  switch(mainCondition.toLowerCase()){
    case 'clouds':
    case 'mist':
    case 'smoke':
    case 'haze':
    case 'dust':
    case 'fog':
    
    return 'assets/cloudy.json';
    case 'rain':
    case 'drizzle':
    case 'shower rain':
    return 'assets/rainy.json';
    case 'thunderstrom':
    return 'assets/thunder.json';
    default:
    return 'assets/sunny.json';

  }

}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
      backgroundColor: Colors.black,
      title: Text("Weather",style: TextStyle(color: Colors.white),),),
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(_weather?.cityName??"loading city.."
          ,style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.white)
          ),
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
          Text('${_weather?.temperature.round()}°C'
          ,style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.white)
          ),
          Text(_weather?.mainCondition??"",
          style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.white)
          ,)

      
        ],),
      ),
    );
  }
}
