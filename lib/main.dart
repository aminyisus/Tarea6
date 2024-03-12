import 'package:flutter/material.dart';
import 'package:tarea6/toolbox.dart';
import 'package:tarea6/gender_prediction.dart';
import 'package:tarea6/age_determination.dart';
import 'package:tarea6/universities.dart';
import 'package:tarea6/weather.dart';
import 'package:tarea6/wordpress_news.dart';
import 'package:tarea6/about.dart';

//Amín Jesús Báez Espinosa 2021-0929

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToolboxPage(), 
      routes: {
        '/toolbox': (context) => ToolboxPage(),
        '/gender_prediction': (context) => GenderPredictionPage(),
        '/age_determination': (context) => AgeDeterminationPage(),
        '/universities': (context) => UniversitiesPage(),
        '/weather': (context) => WeatherPage(),
        '/wordpress_news': (context) => WordpressNewsPage(),
        '/about': (context) => AboutPage(),
      },
    );
  }
}
