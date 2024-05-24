import 'package:exit_travil/data/models/city_model.dart';
import 'package:exit_travil/data/models/country_model.dart';
import 'package:exit_travil/data/models/photo_model.dart';
import 'package:exit_travil/domin/entities/base_response.dart';

class ResponsePhotos extends BaseResponse {
  const ResponsePhotos(
      {required super.currentPage,
      required super.totalPages,
      required super.items});

  factory ResponsePhotos.fromJson(Map<String, dynamic> json) => ResponsePhotos(
      currentPage: json["currentPage"],
      totalPages: json["totalPages"],
      items: List<PhotoResponse>.from(
          (json["items"] as List).map((e) => PhotoResponse.fromJson(e))));
}

class PhotoResponse {
 final PhotoModel photo;
 final CityModel? city;
 final CountryModel? country;

  PhotoResponse(
      {required this.photo, required this.city, required this.country});

 factory PhotoResponse.fromJson(Map<String, dynamic> json) => PhotoResponse(
      photo : PhotoModel.fromJson(json['photo']),
      city :json['city']!=null? CityModel.fromJson(json['city']):null,
      country :json['country']!=null? CountryModel.fromJson(json['country']):null);
}
