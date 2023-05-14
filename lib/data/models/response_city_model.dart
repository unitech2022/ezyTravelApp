import 'package:exit_travil/data/models/city_model.dart';
import 'package:exit_travil/data/models/country_model.dart';
import 'package:exit_travil/data/models/photo_model.dart';
import 'package:exit_travil/data/models/place_model.dart';
import 'package:exit_travil/data/models/weather_model.dart';
import '../../domin/entities/city_response.dart';

class ResponseCityModel extends CityResponse {
  ResponseCityModel(
      {required super.city,
      required super.weather,
      required super.places,
      required super.photos,
      required super.country,
      required super.videos});

  factory ResponseCityModel.fromJson(Map<String, dynamic> json) =>
      ResponseCityModel(
          city: CityModel.fromJson(json["city"]),
          weather: WeatherModel.fromJson(json["weather"]),
          country: CountryModel.fromJson(json["country"]),
          places: List<PlaceModel>.from(
              (json["places"] as List).map((e) => PlaceModel.fromJson(e))),
          photos: List<PhotoModel>.from(
              (json["photos"] as List).map((e) => PhotoModel.fromJson(e))),
          videos: List<PhotoModel>.from(
              (json["videos"] as List).map((e) => PhotoModel.fromJson(e))));
}
