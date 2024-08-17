import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather/weather/domain/either.dart';
import 'package:open_weather/weather/domain/repositories/weather_repository.dart';

import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({
    required WeatherRepository weatherRepository,
  })  : _weatherRepository = weatherRepository,
        super(const WeatherLoading());

  final WeatherRepository _weatherRepository;

  Future<void> initialize() async {
    emit(const WeatherLoading());
    final result = await _weatherRepository.query();
    emit(switch (result) {
      Left() => const WeatherFailure(),
      Right(:final value) => WeatherLoaded(report: value),
    });
  }
}
