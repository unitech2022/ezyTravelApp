import '../../domin/entities/Photo.dart';

class PhotoModel extends Photo {
   const PhotoModel(
      {required super.id,
      required super.image,
      required super.cityId,
      required super.type,
      required super.placeId});

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
      id: json["id"], image: json["image"], placeId: json["placeId"],cityId: json["cityId"],type: json["type"]);
}

