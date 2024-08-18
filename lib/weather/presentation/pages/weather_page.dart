import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather/core/presentation/widgets/breakpoint_builder.dart';
import 'package:open_weather/core/presentation/widgets/constrained_by_mobile.dart';
import 'package:open_weather/core/presentation/widgets/loading_indicator.dart';
import 'package:open_weather/weather/presentation/cubits/weather_cubit.dart';
import 'package:open_weather/weather/presentation/cubits/weather_state.dart';
import 'package:open_weather/weather/presentation/widgets/dialogs/location_failure_dialog.dart';
import 'package:open_weather/weather/presentation/widgets/failure_mappers.dart';
import 'package:open_weather/weather/presentation/widgets/slivers/sliver_daily_forecast_block.dart';
import 'package:open_weather/weather/presentation/widgets/slivers/sliver_hourly_forecast_block.dart';
import 'package:open_weather/weather/presentation/widgets/slivers/sliver_now_block.dart';
import 'package:open_weather/weather/presentation/widgets/slivers/sliver_weather_app_bar.dart';
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
              WeatherLoaded() => BreakpointBuilder(
                  builder: (breakpoint) {
                    return ConstrainedByMobile(
                      child: CustomScrollView(
                        slivers: [
                          const SliverWeatherAppBar(),
                          SliverNowBlock(
                            current: state.report.current,
                          ),
                          const SliverPadding(
                              padding: EdgeInsets.only(bottom: 32)),
                          SliverHourlyForecastBlock(
                            forecast:
                                state.report.hourly.take(next9Hours).toList(),
                          ),
                          const SliverPadding(
                            padding: EdgeInsets.only(bottom: 32),
                          ),
                          SliverDailyForecastBlock(
                            daily: state.report.daily.take(next8Days).toList(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
            };
          },
        ),
      ),
    );
  }
}
