import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:open_weather/weather/domain/either.dart';
import 'package:open_weather/weather/domain/entities/location_entity.dart';
import 'package:open_weather/weather/domain/failures/location_failure.dart';
import 'package:open_weather/weather/domain/repositories/location_repository.dart';

class SystemLocationRepository implements LocationRepository {
  @override
  Future<Either<LocationFailure, LocationEntity>> query() async {
    try {
      final gpsEnabled = await Geolocator.isLocationServiceEnabled();
      if (!gpsEnabled) {
        return const Left(LocationFailure.gpsDisabled);
      }
      var permission = await Geolocator.checkPermission();
      if (!_hasPermission(permission)) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        return const Left(LocationFailure.deniedForever);
      }
      final position = await Geolocator.getCurrentPosition();
      return Right(
        LocationEntity(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );
    } catch (error, stackTrace) {
      log('could not get the location', error: error, stackTrace: stackTrace);
      return const Left(LocationFailure.unknown);
    }
  }

  bool _hasPermission(LocationPermission permission) => switch (permission) {
        LocationPermission.always || LocationPermission.whileInUse => true,
        _ => false,
      };
}
