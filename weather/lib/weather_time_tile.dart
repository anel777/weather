import 'package:flutter/material.dart';

class WeatherTimeTile extends StatelessWidget {
  final String time;
  final String temperature;
  final String hum;
  final String wind;
  final String weather;
  final bool isDarkMode;

  const WeatherTimeTile({
    required this.time,
    required this.temperature,
    required this.hum,
    required this.wind,
    required this.weather,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    double screenRatio = MediaQuery.of(context).size.aspectRatio;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        padding: EdgeInsets.all(10),
        height: screenRatio * 800,
        width: screenRatio * 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenRatio * 60),
          color: isDarkMode ? Color(0xFF1E1F21) : Color(0xFFB0BCC8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(time), //time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(temperature, style: TextStyle(fontSize: 24)), //Temp
                Icon(_getWeatherIcon(weather), size: 32), //Cloud Icon
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.water_drop),
                    Text(hum),
                  ],
                ),
                Column(
                  //Humidity
                  children: [
                    Icon(Icons.air),
                    Text(wind),
                  ],
                ),
              ],
            ),
            Text(
              '$weather',
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}

IconData _getWeatherIcon(String weatherDescription) {
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
