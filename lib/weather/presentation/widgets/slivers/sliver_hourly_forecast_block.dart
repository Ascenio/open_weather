import 'package:flutter/material.dart';
import 'package:open_weather/weather/domain/entities/weather_data_entity.dart';
import 'package:open_weather/weather/presentation/widgets/forecast_graph/forecast_graph.dart';

class SliverHourlyForecastBlock extends StatelessWidget {
  const SliverHourlyForecastBlock({
    super.key,
    required this.forecast,
  });

  final List<WeatherDataEntity> forecast;

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        const SliverToBoxAdapter(
          child: Text(
            'Hourly forecast',
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 8)),
        SliverToBoxAdapter(
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: ForecastGraph(
              forecast: forecast,
            ),
          ),
        ),
      ],
    );
  }
}
