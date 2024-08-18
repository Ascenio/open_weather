import 'package:open_weather/weather/domain/either.dart';
import 'package:open_weather/weather/domain/entities/address_entity.dart';
import 'package:open_weather/weather/domain/entities/location_entity.dart';

abstract interface class ReverseLocationRepository {
  Future<Either<void, AddressEntity>> query({
    required LocationEntity location,
  });
}
