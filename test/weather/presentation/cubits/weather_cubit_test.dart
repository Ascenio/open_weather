import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_weather/weather/domain/either.dart';
import 'package:open_weather/weather/domain/entities/location_entity.dart';
import 'package:open_weather/weather/domain/entities/weather.dart';
import 'package:open_weather/weather/domain/entities/weather_daily_data_entity.dart';
import 'package:open_weather/weather/domain/entities/weather_data_entity.dart';
import 'package:open_weather/weather/domain/entities/weather_report_entity.dart';
import 'package:open_weather/weather/domain/failures/location_failure.dart';
import 'package:open_weather/weather/domain/repositories/location_repository.dart';
import 'package:open_weather/weather/domain/repositories/weather_repository.dart';
import 'package:open_weather/weather/presentation/cubits/weather_cubit.dart';
import 'package:open_weather/weather/presentation/cubits/weather_state.dart';

class LocationRepositoryMock extends Mock implements LocationRepository {}

class WeatherRepositoryMock extends Mock implements WeatherRepository {}

void main() {
  late LocationRepository locationRepository;
  late WeatherRepository weatherRepository;
  late WeatherCubit cubit;

  setUp(() {
    locationRepository = LocationRepositoryMock();
    weatherRepository = WeatherRepositoryMock();
    cubit = WeatherCubit(
      locationRepository: locationRepository,
      weatherRepository: weatherRepository,
    );
  });

  final report = WeatherReportEntity(
    daily: [
      WeatherDailyDataEntity(
        date: DateTime(2024, 8, 18, 16, 13),
        minimumTemperature: 19,
        maximumTemperature: 34,
        weather: const Weather(title: 'Clouds', icon: '02d'),
      )
    ],
    current: const WeatherDataEntity(
      temperature: 33,
      pressure: 1011,
      humidity: 38,
      windDegrees: 93,
      windSpeed: 3.1,
      weather: Weather(title: 'Clouds', icon: '04d'),
    ),
    hourly: [],
  );

  const location = LocationEntity(
    latitude: -3.8447967,
    longitude: -32.46,
  );

  blocTest<WeatherCubit, WeatherState>(
    'emits [WeatherLoading, WeatherLocationFailure] when fails to query the user location',
    build: () => cubit,
    setUp: () {
      when(() => locationRepository.query())
          .thenAnswer((_) async => const Left(LocationFailure.denied));
    },
    act: (cubit) => cubit.initialize(),
    expect: () => const <WeatherState>[
      WeatherLoading(),
      WeatherLocationFailure(failure: LocationFailure.denied),
    ],
  );

  group('weather fetching', () {
    setUp(() {
      when(() => locationRepository.query())
          .thenAnswer((_) async => const Right(location));
    });

    blocTest<WeatherCubit, WeatherState>(
      'emits [WeatherLoading, WeatherFailure] when fails to initialize',
      build: () => cubit,
      setUp: () {
        when(() => weatherRepository.query(location: location))
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
      build: () => cubit,
      setUp: () {
        when(() => weatherRepository.query(location: location))
            .thenAnswer((_) async => Right(report));
      },
      act: (cubit) => cubit.initialize(),
      expect: () => <WeatherState>[
        const WeatherLoading(),
        WeatherLoaded(report: report),
      ],
    );
  });
}
