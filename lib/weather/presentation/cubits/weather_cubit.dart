import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather/weather/domain/either.dart';
import 'package:open_weather/weather/domain/repositories/location_repository.dart';
import 'package:open_weather/weather/domain/repositories/reverse_location_repository.dart';
import 'package:open_weather/weather/domain/repositories/weather_repository.dart';

import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({
    required this.weatherRepository,
    required this.locationRepository,
    required this.reverseLocationRepository,
  }) : super(const WeatherLoading());

  final WeatherRepository weatherRepository;
  final LocationRepository locationRepository;
  final ReverseLocationRepository reverseLocationRepository;

  Future<void> initialize() async {
    emit(const WeatherLoading());
    switch (await locationRepository.query()) {
      case Left(value: final failure):
        return emit(WeatherLocationFailure(failure: failure));
      case Right(value: final location):
        final resultWeather = await weatherRepository.query(location: location);
        final resultAddress =
            await reverseLocationRepository.query(location: location);
        emit(switch ((resultWeather, resultAddress)) {
          (Right(value: final report), Right(value: final address)) =>
            WeatherLoaded(
              report: report,
              address: address,
            ),
          (Right(value: final report), _) => WeatherLoaded(
              report: report,
            ),
          _ => const WeatherFailure(),
        });
    }
  }
}
