import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({required this.icon, super.key});

  final String icon;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      curve: Curves.ease,
      duration: const Duration(milliseconds: 400),
      child: Image.network(
        'https://openweathermap.org/img/wn/$icon@2x.png',
      ),
    );
  }
}