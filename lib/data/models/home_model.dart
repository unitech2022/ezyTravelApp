import 'package:exit_travil/data/models/continent_model.dart';
import 'package:exit_travil/data/models/photo_model.dart';

import 'package:exit_travil/domin/entities/home.dart';

class HomeModel extends Home{
 const HomeModel({
  required super.welcome,
  required super.continents});
 
 factory HomeModel.fromJson(Map<String ,dynamic> json)
 {

  return HomeModel(welcome: List<PhotoModel>.from((json["welcome"] as List)
      .map((e) => PhotoModel.fromJson(e))),
      continents: List<ContinentModel>.from((json["continents"] as List)
          .map((e) => ContinentModel.fromJson(e))));
 }


}