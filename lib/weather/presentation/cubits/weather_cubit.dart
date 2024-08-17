import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather/weather/domain/either.dart';
import 'package:open_weather/weather/domain/repositories/location_repository.dart';
import 'package:open_weather/weather/domain/repositories/weather_repository.dart';

import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({
    required this.weatherRepository,
    required this.locationRepository,
  }) : super(const WeatherLoading());

  final WeatherRepository weatherRepository;
  final LocationRepository locationRepository;

  Future<void> initialize() async {
    emit(const WeatherLoading());
    switch (await locationRepository.query()) {
      case Left(value: final failure):
        return emit(WeatherLocationFailure(failure: failure));
      case Right(value: final location):
        final result = await weatherRepository.query(location: location);
        emit(switch (result) {
          Left() => const WeatherFailure(),
          Right(:final value) => WeatherLoaded(report: value),
        });
    }
  }
}
