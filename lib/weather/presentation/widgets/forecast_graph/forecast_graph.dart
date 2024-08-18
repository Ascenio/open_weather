import 'package:flutter/material.dart';
import 'package:open_weather/weather/domain/entities/weather_data_entity.dart';
import 'package:open_weather/weather/presentation/widgets/forecast_graph/forecast_painter.dart';

class ForecastGraph extends StatelessWidget {
  const ForecastGraph({
    super.key,
    required this.forecast,
  });

  final List<WeatherDataEntity> forecast;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: TweenAnimationBuilder(
        duration: const Duration(seconds: 2),
        tween: Tween(begin: 0.0, end: 1.0),
        curve: Curves.ease,
        builder: (context, progress, snapshot) {
          final color = DefaultTextStyle.of(context).style.color!;
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CustomPaint(
                painter: ForecastPainter(
                  forecast: forecast,
                  progress: progress,
                  textColor: color,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
