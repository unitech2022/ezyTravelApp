import 'package:exit_travil/domin/entities/continent.dart';

class ContinentModel extends Continent{
 const ContinentModel({required super.id,
    required super.name,
    required super.image,
    required super.status,
    required super.createdAt});

  factory ContinentModel.fromJson(Map<String , dynamic> json)
  => ContinentModel(id: json["id"],
      name: json["name"],
      image: json["image"],
      status: json["status"],
      createdAt: json["createdAt"]);
}