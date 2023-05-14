import 'package:exit_travil/domin/entities/country.dart';

class CountryModel extends Country {
  const CountryModel(
      {required super.id,
      required super.continentId,
      required super.language,
      required super.currency,
      required super.image,
      required super.name,
      required super.status,
      required super.capital,
      required super.createdAt});

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
      id: json["id"],
      continentId: json["continentId"],
      language: json["language"],
      currency: json["currency"],
      image: json["image"],
      name: json["name"],
      capital: json["capital"],
      status: json["status"],
      createdAt: json["createdAt"]);
}
