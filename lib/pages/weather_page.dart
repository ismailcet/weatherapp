import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  // api key
  final _weatherService = WeatherService("86fa44e85c7e7746c66d8a174dfaa1cd");
  Weather? _weather;
  // fetch weather
  _fetchWeather() async{
    String cityName = await _weatherService.getCurrentCity();
    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather=weather;
      });

    }catch(e){
      print(e);
    }

  }
  // weather animations
  String getWeatherAnimation(String mainCondition){
    if(mainCondition == "") return 'assets/loading.json';
    switch (mainCondition.toLowerCase()){
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }


  // init state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather?.cityName ?? "loading city ..."),

            //animtions
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition ?? "")),

            // temperatur
            Text('${_weather?.temperature.round().toString()}°C'),

            // main condition
            Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),
    );
  }
}
