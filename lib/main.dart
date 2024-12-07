import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:weatherapp/pages/home_page.dart';
import 'package:weatherapp/pages/weather_page.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
