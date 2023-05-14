import 'package:equatable/equatable.dart';

import 'Photo.dart';
import 'continent.dart';

class Home extends Equatable {
  final List<Photo> welcome;

  final List<Continent> continents;

  const Home({required this.welcome, required this.continents});

  @override
  List<Object> get props => [welcome, continents];
}