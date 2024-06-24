import 'package:flutter/material.dart';

class History extends StatelessWidget {
  final bool isDarkMode;

  History({
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    double screenRatio = MediaQuery.of(context).size.aspectRatio;
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
                  Color(0xFFF1F6FB),
                  Color(0xFFD3E5F5),
                ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: isDarkMode ? Color(0xFF292B2B) : Color(0xFFB0BCC8),
          centerTitle: true,
          title: Text(
            'WeatherApp',
            style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(color: Colors.amber),
          toolbarHeight: screenRatio * 300,
        ),
        body: ListView(
          children: [
            Padding(
              // Date , place , -- Time
              padding: const EdgeInsets.all(12.0),
              child: Container(
                  padding: EdgeInsets.only(
                      left: screenRatio * 40, right: screenRatio * 40),
                  height: screenRatio * 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        screenRatio * 40,
                      ),
                      color:
                          isDarkMode ? Color(0xFF1E1F21) : Color(0xFFB0BCC8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Wednesday',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'India',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: screenRatio * 40),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '9:30am',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
