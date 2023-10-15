import 'package:equatable/equatable.dart';

import 'package:exit_travil/data/models/home_model.dart';
import 'package:exit_travil/data/models/place_details_model.dart';
import 'package:exit_travil/data/models/place_model.dart';


import 'Photo.dart';
import 'continent.dart';

class Home extends Equatable {
  final List<Photo> welcome;

  final List<Continent> continents;
    final List<ResponseCityHome> mostPopularCities;
      final List<ResponsePlaceHome> mostPopularPlaces;

  const Home({required this.welcome, required this.continents,required this.mostPopularCities, required this.mostPopularPlaces});

  @override
  List<Object> get props => [welcome, continents,mostPopularPlaces,mostPopularCities];
}