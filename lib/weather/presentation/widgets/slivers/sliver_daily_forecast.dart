import 'package:flutter/material.dart';
import 'package:open_weather/weather/domain/entities/weather_daily_data_entity.dart';
import 'package:open_weather/weather/presentation/widgets/formatters/date_formatter.dart';
import 'package:open_weather/weather/presentation/widgets/icons/weather_icon.dart';

class SliverDailyForecast extends StatelessWidget {
  const SliverDailyForecast({
    required this.daily,
    super.key,
  });

  final List<WeatherDailyDataEntity> daily;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemBuilder: (_, index) {
        final item = daily[index];
        return Row(
          children: [
            Expanded(child: Text(dateFormatter(item.date))),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WeatherIcon(
                    icon: item.weather.icon,
                  ),
                  Text(
                      '${item.maximumTemperature.floor()}/${item.minimumTemperature.floor()}°C')
                ],
              ),
            ),
            Expanded(
              child: Text(
                item.weather.title,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        );
      },
      itemCount: daily.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
