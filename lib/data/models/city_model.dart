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


