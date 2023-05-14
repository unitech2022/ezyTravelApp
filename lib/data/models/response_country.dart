import 'package:exit_travil/data/models/country_model.dart';
import 'package:exit_travil/domin/entities/city.dart';
import 'city_model.dart';

class ResponseCountryModel extends CountryResponse {
  const ResponseCountryModel({required super.country, required super.cities});

  factory ResponseCountryModel.fromJson(Map<String, dynamic> json) =>
      ResponseCountryModel(
          country: CountryModel.fromJson(json['country']),
          cities: List<CityModel>.from(
              (json["cities"] as List).map((e) => CityModel.fromJson(e))));
}
