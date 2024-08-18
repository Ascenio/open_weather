import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather/core/presentation/widgets/constrained_by_mobile.dart';
import 'package:open_weather/core/presentation/widgets/loading_indicator.dart';
import 'package:open_weather/weather/presentation/cubits/weather_cubit.dart';
import 'package:open_weather/weather/presentation/cubits/weather_state.dart';
import 'package:open_weather/weather/presentation/widgets/detailed_icon.dart';
import 'package:open_weather/weather/presentation/widgets/dialogs/location_failure_dialog.dart';
import 'package:open_weather/weather/presentation/widgets/failure_mappers.dart';
import 'package:open_weather/weather/presentation/widgets/forecast_graph/forecast_graph.dart';
import 'package:open_weather/weather/presentation/widgets/icons/weather_icon.dart';
import 'package:open_weather/weather/presentation/widgets/icons/wind_icon.dart';
import 'package:open_weather/weather/presentation/widgets/slivers/sliver_daily_forecast.dart';
import 'package:open_weather/weather/presentation/widgets/try_again_widget.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  static const next9Hours = 9;
  static const next8Days = 8;

  @override
  void initState() {
    super.initState();
    context.read<WeatherCubit>().initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<WeatherCubit, WeatherState>(
          listener: (context, state) {
            if (state is WeatherLocationFailure) {
              showLocationFailureDialog(
                context: context,
                failure: state.failure,
              );
            }
          },
          builder: (context, state) {
            return switch (state) {
              WeatherLoading() => const LoadingIndicator(),
              WeatherLocationFailure() => ConstrainedByMobile(
                  child: TryAgainWidget(
                    error: locationFailureToString(state.failure),
                    tryAgain: context.read<WeatherCubit>().initialize,
                  ),
                ),
              WeatherFailure() => ConstrainedByMobile(
                  child: TryAgainWidget(
                    error: 'Ops, something went wrong!',
                    tryAgain: context.read<WeatherCubit>().initialize,
                  ),
                ),
              WeatherLoaded() => ConstrainedByMobile(
                  child: CustomScrollView(
                    slivers: [
                      const SliverAppBar(
                        title: Text('Open Weather 🌥️'),
                        snap: true,
                        floating: true,
                      ),
                      const SliverToBoxAdapter(
                        child: Text(
                          'Now',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SliverPadding(padding: EdgeInsets.only(bottom: 8)),
                      SliverToBoxAdapter(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${state.report.current.temperature}°C',
                                  style: const TextStyle(
                                    fontSize: 28,
                                  ),
                                ),
                                WeatherIcon(
                                  size: 64,
                                  icon: state.report.current.weather.icon,
                                ),
                              ],
                            ),
                            IconListItem(
                              icon: const Icon(Icons.water_drop_outlined),
                              label:
                                  'Humidity: ${state.report.current.humidity}%',
                            ),
                            IconListItem(
                              icon: const Icon(Icons.thermostat_outlined),
                              label:
                                  'Pressure: ${state.report.current.pressure}hPa',
                            ),
                            IconListItem(
                              icon: WindIcon(
                                degrees: state.report.current.windDegrees,
                              ),
                              label: '${state.report.current.windSpeed}m/s',
                            ),
                          ],
                        ),
                      ),
                      const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
                      const SliverToBoxAdapter(
                        child: Text(
                          'Hourly forecast',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SliverPadding(padding: EdgeInsets.only(bottom: 8)),
                      SliverToBoxAdapter(
                        child: ForecastGraph(
                          forecast:
                              state.report.hourly.take(next9Hours).toList(),
                        ),
                      ),
                      const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
                      const SliverToBoxAdapter(
                        child: Text(
                          '8-day forecast',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SliverPadding(padding: EdgeInsets.only(bottom: 8)),
                      SliverDailyForecast.sliverList(
                        daily: state.report.daily.take(next8Days).toList(),
                      ),
                    ],
                  ),
                ),
            };
          },
        ),
      ),
    );
  }
}
