import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather/history.dart';
import 'package:weather/weather_screen.dart';

class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggleDarkMode;

  const HomeScreen({required this.isDarkMode, required this.onToggleDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDarkMode
              ? [
                  Color(0xFF292B2B),
                  Color(0xFF212524),
                ]
              : [
                  Color(0xFFD3E5F5),
                  Color(0xFFF1F6FB), // Middle lighter shade
                  Color(0xFFD3E5F5),
                ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: isDarkMode ? Color(0xFF292B2B) : Color(0xFFD3E5F5),
          centerTitle: true,
          title: Text(
            'WeatherApp',
            style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
          iconTheme: IconThemeData(color: Colors.amber),
        ),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text('History'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => History(
                          isDarkMode: isDarkMode,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.dark_mode),
                  title: Text('Dark mode'),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      onToggleDarkMode();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: WeatherScreen(
          isDarkMode: isDarkMode,
        ),
      ),
    );
  }
}
