import 'package:flutter/material.dart';
import 'package:weather/weather_time_tile.dart';

class WeatherScreen extends StatelessWidget {
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
                    Text('IN | Kottakkal', style: TextStyle(fontSize: 30)),
                    Text(
                      'Scattered Clouds',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('34°', style: TextStyle(fontSize: screenRatio * 160)),
                  Icon(Icons.cloud, size: screenRatio * 165),
                ],
              ),
              SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenRatio * 40),
                  color: Colors.black87,
                ),
                padding: EdgeInsets.all(screenRatio * 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.thermostat, size: 50),
                        Text('41°'),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.water_drop_outlined, size: 80),
                        Text(
                          '49%',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.air, size: 50),
                        Text('3 km/h'),
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
              children: [
                WeatherTimeTile(
                    time: '09:00 AM',
                    temperature: '38°',
                    prob: '57%',
                    wind: '5km/h'),
                WeatherTimeTile(
                    time: '12:00 PM',
                    temperature: '33°',
                    prob: '59%',
                    wind: '9km/h'),
                WeatherTimeTile(
                    time: '04:00 PM',
                    temperature: '34°',
                    prob: '52%',
                    wind: '2km/h'),
                WeatherTimeTile(
                    time: '04:00 PM',
                    temperature: '34°',
                    prob: '46%',
                    wind: '14km/h'),
                WeatherTimeTile(
                    time: '04:00 PM',
                    temperature: '34°',
                    prob: '29%',
                    wind: '2km/h'),
              ],
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
      ],
    );
  }
}
