import 'package:equatable/equatable.dart';
import 'package:exit_travil/data/models/city_model.dart';
import 'package:exit_travil/data/models/continent_model.dart';
import 'package:exit_travil/data/models/country_model.dart';
import 'package:exit_travil/data/models/photo_model.dart';
import 'package:exit_travil/data/models/place_model.dart';
import 'package:exit_travil/domin/entities/city.dart';
import 'package:exit_travil/domin/entities/country.dart';

import 'package:exit_travil/domin/entities/home.dart';
import 'package:exit_travil/domin/entities/place.dart';

class HomeModel extends Home {
  const HomeModel(
      {required super.welcome,
      required super.continents,
      required super.mostPopularCities,
      required super.mostPopularPlaces});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
        welcome: List<PhotoModel>.from(
            (json["welcome"] as List).map((e) => PhotoModel.fromJson(e))),
        continents: List<ContinentModel>.from((json["continents"] as List)
            .map((e) => ContinentModel.fromJson(e))),
        mostPopularCities: List<ResponseCityHome>.from(
            (json["mostPopularCities"] as List)
                .map((e) => ResponseCityHome.fromJson(e))),
        mostPopularPlaces: List<ResponsePlaceHome>.from(
            (json["mostPopularPlaces"] as List)
                .map((e) => ResponsePlaceHome.fromJson(e))));
  }
}

class ResponseCityHome extends Equatable {
  final City city;

  final Country country;
  ResponseCityHome({
    required this.city,
    required this.country,
  });

  factory ResponseCityHome.fromJson(Map<String, dynamic> json) =>
      ResponseCityHome(
        city: CityModel.fromJson(json["city"]),
        country: CountryModel.fromJson(json["country"]),
      );

  @override
  // TODO: implement props
  List<Object?> get props => [city, country];
}

class ResponsePlaceHome extends Equatable {
  final Place place;
  final City city;
  final Country country;
  ResponsePlaceHome({
      required this.city,
    required this.place,
    required this.country,
  });

  factory ResponsePlaceHome.fromJson(Map<String, dynamic> json) =>
      ResponsePlaceHome(
        place: PlaceModel.fromJson(json["place"]),
          city: CityModel.fromJson(json["city"]),
        country: CountryModel.fromJson(json["country"]),
      );

  @override

  List<Object?> get props => [place, country,city];
}
