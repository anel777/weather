import 'package:flutter/material.dart';

class WeatherTimeTile extends StatelessWidget {
  final String time;
  final String temperature;
  final String prob;
  final String wind;
  final bool isDarkMode;

  const WeatherTimeTile({
    required this.time,
    required this.temperature,
    required this.prob,
    required this.wind,
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
                Icon(Icons.cloud, size: 32), //Cloud Icon
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.water_drop),
                    Text(wind),
                  ],
                ),
                Column(
                  //Raining probability
                  children: [
                    Icon(Icons.air_rounded),
                    Text(prob),
                  ],
                ),
              ],
            ),
            Text(
              'Scattered Clouds',
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}
