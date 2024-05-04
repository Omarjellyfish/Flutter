import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_weather/service/weather_service.dart';
import 'package:flutter_application_weather/models/weather_model.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService =
      WeatherService('8ae19306d9d72048810594880801b0ee'); //api key here
  Weather? _weather;
  //fetch weather
  _fetchWeather() async {
    //get cur city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }
  //weather anim

  //initial state
  @override
  void initState() {
    super.initState();
    //fetch weather on start up
    _fetchWeather();
  }

  String getWeatherAnim(String? mainCondition) {
    if (mainCondition == null) return 'assets/Sunny.json'; //defult
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/Cloudy.json';
      case 'rain':
        return 'assets/Rainy.json';
      case 'thunderstorm':
        return 'assets/Stormy.json';
      case 'snow':
        return 'assets/Snowy.json';
      case 'clear':
        return 'assets/Sunny.json';
      default:
        return 'assets/Sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(_weather?.cityName ?? 'loading city'),
      Lottie.asset(getWeatherAnim(_weather?.mainCondition)),
      Text('${_weather?.temprature.round()}°C'),
      Text(_weather?.mainCondition ?? 'hmm')
    ])));
  }
}
