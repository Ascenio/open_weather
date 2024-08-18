import 'package:flutter/material.dart';

class SliverWeatherAppBar extends StatelessWidget {
  const SliverWeatherAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      title: Text('Open Weather 🌥️'),
      snap: true,
      floating: true,
    );
  }
}
