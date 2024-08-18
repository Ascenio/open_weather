import 'package:flutter/material.dart';
import 'package:open_weather/weather/domain/entities/weather_daily_data_entity.dart';
import 'package:open_weather/weather/presentation/widgets/formatters/date_formatter.dart';
import 'package:open_weather/weather/presentation/widgets/icons/weather_icon.dart';

class SliverDailyForecast extends StatelessWidget {
  const SliverDailyForecast.listView({
    required this.daily,
    super.key,
  }) : isSliver = false;

  const SliverDailyForecast.sliverList({
    required this.daily,
    super.key,
  }) : isSliver = true;

  final List<WeatherDailyDataEntity> daily;
  final bool isSliver;

  @override
  Widget build(BuildContext context) {
    if (isSliver) {
      return SliverList.separated(
        itemBuilder: _itemBuilder,
        itemCount: daily.length,
        separatorBuilder: _separatorBuilder,
      );
    }
    return ListView.separated(
      itemBuilder: _itemBuilder,
      itemCount: daily.length,
      separatorBuilder: _separatorBuilder,
    );
  }

  Widget _itemBuilder(BuildContext _, int index) {
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
              Flexible(
                child: Text(
                    '${item.maximumTemperature.floor()}/${item.minimumTemperature.floor()}°C'),
              )
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
  }

  Widget _separatorBuilder(BuildContext _, int index) =>
      const SizedBox(height: 8);
}
