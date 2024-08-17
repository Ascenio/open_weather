import 'package:flutter_bloc/flutter_bloc.dart';
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
    final report = await _weatherRepository.query();
    if (report == null) {
      emit(const WeatherFailure());
    } else {
      emit(WeatherLoaded(report: report));
    }
  }
}
