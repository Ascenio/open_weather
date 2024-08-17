import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather/core/presentation/widgets/loading_indicator.dart';
import 'package:open_weather/weather/presentation/cubits/weather_cubit.dart';
import 'package:open_weather/weather/presentation/cubits/weather_state.dart';
import 'package:open_weather/weather/presentation/widgets/custom_colors.dart';
import 'package:open_weather/weather/presentation/widgets/detailed_icon.dart';
import 'package:open_weather/weather/presentation/widgets/forecast_graph/forecast_graph.dart';
import 'package:open_weather/weather/presentation/widgets/icons/weather_icon.dart';
import 'package:open_weather/weather/presentation/widgets/icons/wind_icon.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
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
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            return switch (state) {
              WeatherLoading() => const LoadingIndicator(),
              WeatherFailure() => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Ops, something went wrong!',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          icon: const Icon(Icons.refresh),
                          iconAlignment: IconAlignment.end,
                          label: const Text('Try again'),
                          onPressed: context.read<WeatherCubit>().initialize,
                        ),
                      )
                    ],
                  ),
                ),
              WeatherLoaded() => CustomScrollView(
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
                                icon: state.report.current.weather.icon,
                              ),
                            ],
                          ),
                          IconListItem(
                            icon: const Icon(
                              Icons.water_drop_outlined,
                              color: CustomColors.icons,
                            ),
                            label:
                                'Humidity: ${state.report.current.humidity}%',
                          ),
                          IconListItem(
                            icon: const Icon(
                              Icons.thermostat_outlined,
                              color: CustomColors.icons,
                            ),
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
                        forecast: state.report.hourly,
                      ),
                    )
                  ],
                ),
            };
          },
        ),
      ),
    );
  }
}
