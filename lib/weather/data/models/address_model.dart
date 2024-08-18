import 'package:open_weather/weather/domain/entities/address_entity.dart';

final class AddressModel extends AddressEntity {
  const AddressModel({
    required super.city,
    required super.state,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      city: json['address']['city'],
      state: json['address']['state'],
    );
  }
}
