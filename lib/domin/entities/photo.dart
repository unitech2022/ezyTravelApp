import 'package:equatable/equatable.dart';

class Photo extends Equatable  {
  final int id;
  final String image;
  final int placeId;
  final int cityId;
  final int type;

  const Photo({required this.id, required this.image, required this.placeId,required this.cityId, required this.type});

  @override

  List<Object?> get props => [
    id,
    image ,
    placeId,
    cityId,
    type
  ];
}
