import 'package:flutter/material.dart';
import 'package:weather/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode
          ? ThemeData.dark().copyWith(
              textTheme:
                  Typography.material2021().white.apply(fontFamily: 'Chakra'),
            )
          : ThemeData.light().copyWith(
              iconTheme: IconThemeData(color: Color(0xFF245B82)),
              textTheme: Typography.material2021()
                  .black
                  .apply(
                    fontFamily: 'Chakra',
                    bodyColor: Color(0xFF245B82),
                    displayColor: Color(0xFF245B82),
                  )
                  .copyWith(
                    bodyLarge: TextStyle(
                        color: Color(0xFF245B82), fontFamily: 'Chakra'),
                    bodyMedium: TextStyle(
                        color: Color(0xFF245B82), fontFamily: 'Chakra'),
                    titleLarge: TextStyle(
                        color: Color(0xFF245B82), fontFamily: 'Chakra'),
                    titleMedium: TextStyle(
                        color: Color(0xFF245B82), fontFamily: 'Chakra'),
                    titleSmall: TextStyle(
                        color: Color(0xFF245B82), fontFamily: 'Chakra'),
                  ),
            ),
      home: HomeScreen(
        isDarkMode: isDarkMode,
        onToggleDarkMode: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
      ),
    );
  }
}
