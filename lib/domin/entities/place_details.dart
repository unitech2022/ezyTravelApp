import 'package:equatable/equatable.dart';
import 'package:exit_travil/domin/entities/city.dart';
import 'package:exit_travil/domin/entities/country.dart';

import 'package:exit_travil/domin/entities/place.dart';

class PlaceDetails extends Equatable {
  final City city;
  final Place place;
  final Country country;
  final List<String> photos;
  final List<String> videos;

  const PlaceDetails({
    required this.city,
    required this.place,
    required this.country,
    required this.photos,
    required this.videos
  });

  @override
  List<Object> get props => [city, place, country,photos,videos];
}
