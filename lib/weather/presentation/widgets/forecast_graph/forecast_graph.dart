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
    final color = DefaultTextStyle.of(context).style.color!;
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: TweenAnimationBuilder(
            duration: const Duration(seconds: 2),
            tween: Tween(begin: 0.0, end: 1.0),
            curve: Curves.ease,
            builder: (_, progress, __) {
              return CustomPaint(
                painter: ForecastPainter(
                  forecast: forecast,
                  progress: progress,
                  textColor: color,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
