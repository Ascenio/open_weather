import 'package:open_weather/weather/domain/failures/location_failure.dart';

String locationFailureToString(LocationFailure failure) {
  return switch (failure) {
    LocationFailure.gpsDisabled => 'GPS is disabled.',
    LocationFailure.denied => 'Permission was denied.',
    LocationFailure.deniedForever => 'Permission was denied forever!',
    LocationFailure.unknown => 'Ops, something went wrong!',
  };
}
