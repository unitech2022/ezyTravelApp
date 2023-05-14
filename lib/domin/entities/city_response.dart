import 'package:exit_travil/domin/entities/Photo.dart';
import 'package:exit_travil/domin/entities/city.dart';
import 'package:exit_travil/domin/entities/country.dart';
import 'package:exit_travil/domin/entities/place.dart';
import 'package:exit_travil/domin/entities/weather.dart';

class CityResponse{
  final City city;
  final Weather weather;
  final Country country;
  final List<Place> places;
  final List<Photo> photos;
  final List<Photo> videos;

  CityResponse({required this.city, required this.weather,
    required this.places, required this.photos,required this.country,required this.videos});
}