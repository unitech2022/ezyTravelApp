
import 'package:exit_travil/data/models/city_model.dart';
import 'package:exit_travil/data/models/country_model.dart';

import 'package:exit_travil/data/models/place_model.dart';
import 'package:exit_travil/domin/entities/place_details.dart';

class PlaceDetailsModel extends PlaceDetails {
  const PlaceDetailsModel(
      {required super.city,
      required super.place,
      required super.country,
      required super.photos,
      required super.videos});

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) =>
      PlaceDetailsModel(
          city: CityModel.fromJson(json["city"]),
          place: PlaceModel.fromJson(json["place"]),
          country: CountryModel.fromJson(json["country"]),
          photos: List<String>.from((json["photos"] as List).map((e) => e)),
          videos: List<String>.from((json["videos"] as List).map((e) => e)));
}
