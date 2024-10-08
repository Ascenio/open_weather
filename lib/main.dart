import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather/authentication/data/repositories/local_authentication_repository.dart';
import 'package:open_weather/authentication/presentation/cubits/login_cubit.dart';
import 'package:open_weather/authentication/presentation/pages/login_page.dart';
import 'package:open_weather/core/config/routes.dart';
import 'package:open_weather/core/data/external_http_client.dart';
import 'package:open_weather/weather/data/repositories/remote_reverse_location_repository.dart';
import 'package:open_weather/weather/data/repositories/remote_weather_repository.dart';
import 'package:open_weather/weather/data/repositories/system_location_repository.dart';
import 'package:open_weather/weather/presentation/cubits/weather_cubit.dart';
import 'package:open_weather/weather/presentation/pages/weather_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      routes: {
        Routes.login: (_) => BlocProvider(
              create: (_) => LoginCubit(
                authenticationRepository: const LocalAuthenticationRepository(),
              ),
              child: const LoginPage(),
            ),
        Routes.weather: (_) => BlocProvider(
              create: (_) => WeatherCubit(
                locationRepository: SystemLocationRepository(),
                reverseLocationRepository:
                    const RemoteReverseLocationRepository(
                  httpClient: ExternalHttpClient(
                    url: String.fromEnvironment('REVERSE_BASE_URL'),
                  ),
                ),
                weatherRepository: const RemoteWeatherRepository(
                  httpClient: ExternalHttpClient(
                    url: String.fromEnvironment('BASE_URL'),
                  ),
                  apiKey: String.fromEnvironment('API_KEY'),
                ),
              ),
              child: const WeatherPage(),
            ),
      },
      initialRoute: Routes.login,
    );
  }
}
