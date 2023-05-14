import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String cityName;
  final String temp;
  final String summary;
  final String icon;

  const Weather(
      {required this.cityName, required this.temp, required this.summary, required this.icon});

  @override
  List<Object> get props => [cityName, temp, summary, icon];
}