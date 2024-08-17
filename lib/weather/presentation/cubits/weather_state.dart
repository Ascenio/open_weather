import 'package:equatable/equatable.dart';
import 'package:open_weather/weather/domain/entities/weather_report_entity.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

final class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

final class WeatherFailure extends WeatherState {
  const WeatherFailure();
}

final class WeatherLoaded extends WeatherState {
  const WeatherLoaded({
    required this.report,
  });

  final WeatherReportEntity report;

  @override
  List<Object?> get props => [super.props, report];
}
