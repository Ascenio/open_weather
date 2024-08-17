import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_weather/weather/domain/either.dart';
import 'package:open_weather/weather/domain/entities/weather.dart';
import 'package:open_weather/weather/domain/entities/weather_data_entity.dart';
import 'package:open_weather/weather/domain/entities/weather_report_entity.dart';
import 'package:open_weather/weather/domain/repositories/weather_repository.dart';
import 'package:open_weather/weather/presentation/cubits/weather_cubit.dart';
import 'package:open_weather/weather/presentation/cubits/weather_state.dart';

class WeatherRepositoryMock extends Mock implements WeatherRepository {}

void main() {
  late WeatherRepository weatherRepository;

  setUp(() {
    weatherRepository = WeatherRepositoryMock();
  });

  const report = WeatherReportEntity(
    current: WeatherDataEntity(
      temperature: 33,
      pressure: 1011,
      humidity: 38,
      weather: Weather(title: 'Clouds', icon: '04d'),
    ),
    hourly: [],
  );

  blocTest<WeatherCubit, WeatherState>(
    'emits [WeatherLoading, WeatherFailure] when fails to initialize',
    build: () => WeatherCubit(
      weatherRepository: weatherRepository,
    ),
    setUp: () {
      when(() => weatherRepository.query())
          .thenAnswer((_) async => const Left(null));
    },
    act: (cubit) => cubit.initialize(),
    expect: () => const <WeatherState>[
      WeatherLoading(),
      WeatherFailure(),
    ],
  );

  blocTest<WeatherCubit, WeatherState>(
    'emits [WeatherLoading, WeatherLoaded] when initializes successfully',
    build: () => WeatherCubit(
      weatherRepository: weatherRepository,
    ),
    setUp: () {
      when(() => weatherRepository.query())
          .thenAnswer((_) async => const Right(report));
    },
    act: (cubit) => cubit.initialize(),
    expect: () => const <WeatherState>[
      WeatherLoading(),
      WeatherLoaded(report: report),
    ],
  );
}
