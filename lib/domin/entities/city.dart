import 'package:equatable/equatable.dart';
import 'package:exit_travil/data/models/city_model.dart';
import 'package:exit_travil/data/models/country_model.dart';

import 'country.dart';

class City extends Equatable {
  final int id;
  final int countryId;
  final String title;
  final String image;
  final int status;
  final String createdAt;

  const City(
      {required this.id,
      required this.countryId,
      required this.title,
      required this.image,
      required this.status,
      required this.createdAt});

  @override
  List<Object> get props => [
        id,
        countryId,
        title,
        image,
        status,
        createdAt,
      ];
}

class SearchResponse extends Equatable {
  final City city;
  final Country country;
  const SearchResponse({required this.country, required this.city});

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
      country: CountryModel.fromJson(json['country']),
      city: CityModel.fromJson(json['city']));
 

  @override
  // TODO: implement props
  List<Object?> get props => [country, city];
}

class CountryResponse extends Equatable {
  final Country country;
  final List<City> cities;

  const CountryResponse({required this.country, required this.cities});

  @override
  // TODO: implement props
  List<Object?> get props => [country, cities];
}
