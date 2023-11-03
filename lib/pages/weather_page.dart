import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // API KEY
  final _weatherService = WeatherService('857b35343eb36c5d5ce1b4d016935693');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // any errors
    catch (e) {
      print(e);
    }
  }

  // weather animations
  String getWeatherAnimations(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return "assets/cloud.json";
      case "mist":
      case "smoke":
      case "dust":
      case "fog":
        return "assets/mist.json";
      case "haze":
        return "assets/partly cloudy.json";
      case "rain":
        return "assets/storm and showers day.json";
      case "drizzle":
        return "assets/partly shower.json";
      case 'thunderstorm':
        return "assets/thunder.json";
      case "clear":
        return "assets/sunny.json";
      default:
        return "assets/sunny.json";
    }
  }

  // init state
  @override
  void initState() {
    super.initState();

    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Column(
                children: [
                  // location icon
                  FaIcon(FontAwesomeIcons.locationDot, color: Theme.of(context).colorScheme.secondary,),
                  // city name
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _weather?.cityName ?? "loading city...".toUpperCase(),
                    style: GoogleFonts.oswald(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),

            // animations
            Lottie.asset(getWeatherAnimations(_weather?.mainCondition)),

            // temprature
            Container(
              child: Column(
                children: [
                  Text(
                    "${_weather?.temperature.round()}°C",
                    style: GoogleFonts.oswald(
                      fontSize: 45,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),

                  // weather condition
                  Text(
                    _weather?.mainCondition ?? "Loading Condition 📦",
                    style: GoogleFonts.tiltNeon(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
