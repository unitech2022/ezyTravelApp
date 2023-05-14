import 'package:exit_travil/domin/entities/weather.dart';

class WeatherModel extends Weather{
  const WeatherModel({required super.cityName, required super.temp, required super.summary, required super.icon});

  factory WeatherModel.fromJson(Map<String,dynamic>json)=>
      WeatherModel(cityName: json["cityName"]??"", temp: json["temp"]??"0.0",
          summary: json["summary"]??"", icon: json["icon"]??"");
}