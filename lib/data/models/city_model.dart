import 'package:exit_travil/data/models/place_model.dart';

import '../../domin/entities/city.dart';

class CityModel extends City {
  const CityModel(
      {required super.id,
      required super.countryId,
      required super.title,
      required super.image,
      required super.status,
      required super.createdAt});

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
      id: json["id"],
      countryId: json["countryId"],
      title: json["title"],
      image: json["image"],
      status: json["status"],
      createdAt: json["createdAt"]);
}

class FavResponse {
  final List<CityModel> cities;
  final List<PlaceModel> places;
  FavResponse({required this.cities, required this.places});

  factory FavResponse.fromJson(Map<String, dynamic> json) => FavResponse(
      cities: List<CityModel>.from(
          (json["cities"] as List).map((e) => CityModel.fromJson(e))),
      places: List<PlaceModel>.from(
          (json["places"] as List).map((e) => PlaceModel.fromJson(e))));
}
