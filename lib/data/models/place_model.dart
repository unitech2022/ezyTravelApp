import '../../domin/entities/place.dart';

class PlaceModel extends Place{
  const PlaceModel({required super.id, required super.countryId, required super.cityId, required super.title, required super.desc, required super.image, required super.status, required super.createdAt, required super.latLng, required super.addressName});

  factory PlaceModel.fromJson(Map<String ,dynamic>json)
  =>PlaceModel(id: json["id"], countryId: json["countryId"],
      cityId: json["cityId"],
      title: json["title"],
      desc: json["desc"],
       latLng: json["latLng"],
      addressName: json["addressName"],
      image: json["image"], status: json["status"],
      createdAt: json["createdAt"]);
}