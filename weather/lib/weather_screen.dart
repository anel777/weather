import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:country_codes/country_codes.dart';
import 'package:weather/weather_time_tile.dart';

const apiKey = '2f9215cf2add5c2c341067c93bd088ba'; //From openweathermap.org

class WeatherScreen extends StatefulWidget {
  final bool isDarkMode;

  WeatherScreen({required this.isDarkMode});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String _locationLocality = '';
  String _locationCountry = '';

  String _weatherDescription = '';
  double _temperature = 0.0;
  int _humidity = 0;
  double _windSpeed = 0.0;
  List<WeatherForecast> _forecastData = [];

  @override
  void initState() {
    super.initState();
    _initializeCountryCodes();
  }

  Future<void> _initializeCountryCodes() async {
    try {
      await CountryCodes.init();
    } catch (e) {
      print('Failed to initialize CountryCodes: $e');
    }
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    //Method to get the Current location Using Geolocated for Services and permissions
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationLocality = 'Location services are disabled.';
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationLocality =
            'Location permissions are permanently denied, we cannot request permissions.';
      });
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        setState(() {
          _locationLocality =
              'Location permissions are denied (actual value: $permission).';
        });
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];

    setState(() {
      _locationLocality = '${placemark.locality}';
      //To get Country Code
      final countryDetails = CountryCodes.detailsForLocale(
          Locale.fromSubtags(countryCode: placemark.isoCountryCode));
      _locationCountry = countryDetails?.alpha2Code ?? '';
    });

    _fetchWeather(position.latitude, position.longitude);
  }

  Future<void> _fetchWeather(double lat, double lon) async {
    //Method which fetches current weather from openweathermap and updates the current
    final url =
        'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _weatherDescription = data['weather'][0]['main'];
        _temperature = data['main']['temp'];
        _humidity = data['main']['humidity'];
        _windSpeed = data['wind']['speed'];
      });
    } else {
      setState(() {
        _locationLocality = 'Failed to load weather data.';
      });
    }

    _fetchForecast(lat, lon);
  }

  Future<void> _fetchForecast(double lat, double lon) async {
    //used to fetch the forecase and store it in forecasts
    final url =
        'http://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['list'] as List<dynamic>;
      List<WeatherForecast> forecasts = [];

      for (var item in data) {
        forecasts.add(WeatherForecast(
          //WeatherForecast is a user created Widget to create an UI (in app above 5 day forecast title)
          time: item['dt_txt'].toString().substring(11, 16),
          temperature: item['main']['temp'].toString(),
          humidity: item['main']['humidity'].toString(),
          wind: item['wind']['speed'].toString(),
          weather: item['weather'][0]['main'].toString(),
        ));
      }

      setState(() {
        _forecastData = forecasts;
      });
    } else {
      setState(() {
        _locationLocality = 'Failed to load forecast data.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenRatio = MediaQuery.of(context).size.aspectRatio;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${_locationCountry.toUpperCase()} | ${_locationLocality}',
                        style: TextStyle(fontSize: 30)),
                    Text(
                      _weatherDescription,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('${_temperature.round()}°',
                      style: TextStyle(fontSize: screenRatio * 160)),
                  Icon(
                    _getWeatherIcon(_weatherDescription),
                    size: screenRatio * 165,
                  ),
                ],
              ),
              SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenRatio * 40),
                  color:
                      widget.isDarkMode ? Color(0xFF23282B) : Color(0xFFB0BCC8),
                ),
                padding: EdgeInsets.all(screenRatio * 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.thermostat, size: 50),
                        Text('${_temperature.round()}°'),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.water_drop_outlined, size: 80),
                        Text(
                          '$_humidity%',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.air, size: 50),
                        Text('$_windSpeed km/h'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Text(
          'Today',
          style: TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              //forecast in _forecastData and for each forecast it creates a widget (Similiar to json mapping)
              children: _forecastData
                  .map((forecast) => WeatherTimeTile(
                        time: forecast.time,
                        temperature: forecast.temperature,
                        hum: forecast.humidity,
                        wind: forecast.wind,
                        weather: forecast.weather,
                        isDarkMode: widget.isDarkMode,
                      ))
                  .toList(),
            ),
          ),
        ),
        Text(
          '5 day Forecast',
          style: TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: widget.isDarkMode ? Color(0xFF1E1F21) : Color(0xFFB0BCC8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Wed',
                    style: TextStyle(letterSpacing: 2),
                  ),
                  Text(
                    '9:00',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Icon(Icons.cloud),
              Text('26°C')
            ],
          ),
        ),
      ],
    );
  }

  IconData _getWeatherIcon(String weatherDescription) {
    //This method returns the appropriate Icons for the given weather
    switch (weatherDescription.toLowerCase()) {
      case 'thunderstorm':
        return Icons.cloud_circle;
      case 'drizzle':
        return Icons.grain;
      case 'rain':
        return Icons.beach_access;
      case 'snow':
        return Icons.ac_unit;
      case 'mist':
        return Icons.cloud_circle;
      case 'smoke':
        return Icons.cloud_circle;
      case 'haze':
        return Icons.cloud_circle;
      case 'dust':
        return Icons.cloud_circle;
      case 'fog':
        return Icons.cloud_circle;
      case 'sand':
        return Icons.cloud_circle;
      case 'ash':
        return Icons.cloud_circle;
      case 'squall':
        return Icons.cloud_circle;
      case 'tornado':
        return Icons.cloud_circle;
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.cloud;
      default:
        return Icons.cloud;
    }
  }
}

class WeatherForecast {
  final String time;
  final String temperature;
  final String wind;
  final String humidity;
  final String weather;

  WeatherForecast({
    required this.time,
    required this.temperature,
    required this.humidity,
    required this.wind,
    required this.weather,
  });
}
