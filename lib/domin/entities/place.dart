import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final int id;
  final int countryId;
  final int cityId;
  final String title;
  final String desc;

    final String latLng;
  final String addressName;
  final String image;
  final int status;
  final String createdAt;

  const Place({required this.id,
    required this.countryId,
    required this.cityId,
    required this.title,
    required this.desc,
    required this.image,
    required this.status,
       required this.latLng,
    required this.addressName,
    required this.createdAt});


  @override
  List<Object> get props =>
      [id, countryId, cityId, title, desc, image, status, createdAt,latLng,addressName];
}
