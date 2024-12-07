import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/dialogs/error_dialog.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/weather_services.dart';

class CityPage extends StatefulWidget {
  const CityPage({super.key});

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  final TextEditingController _cityController = TextEditingController();
  final WeatherService _weatherService =
      WeatherService("86fa44e85c7e7746c66d8a174dfaa1cd");
  Weather? _weather;

  void getWeatherToGivenCity() async {
    try {
      final weather = await _weatherService.getWeather(_cityController.text);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      showErrorDialogs(context, 'Hatalı şehir girdiniz !', clearInput());
    }
  }

  void clearInput() {
    _cityController.clear();
  }

  String getWeatherAnimation(String mainCondition) {
    if (mainCondition == "") return 'assets/loading.json';
    switch (mainCondition.toLowerCase()) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: "Enter city name",
                    border: OutlineInputBorder(),
                  ),
                )),
            const SizedBox(
              height: 16,
            ),
            OutlinedButton(
                onPressed: () => getWeatherToGivenCity(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Icon(Icons.search), Text('Search City')],
                )),
            const SizedBox(
              height: 32,
            ),
            if (_weather != null) ...{
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Text(_weather?.cityName ?? 'Loading City'),
                  ),
                  Lottie.asset(
                      getWeatherAnimation(_weather?.mainCondition ?? "")),
                  Text('${_weather?.temperature.round().toString()}°C'),
                  Text(_weather?.mainCondition ?? "")
                ],
              )
            } else if (_weather == null && _cityController.text != "") ...{
              Text("Wrong City Name ! ${_cityController.text}"),
            }
          ],
        ));
  }
}
