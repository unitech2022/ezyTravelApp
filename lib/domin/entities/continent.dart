import 'package:equatable/equatable.dart';

class Continent extends Equatable {

  final int id;

  final String name;
  final String image;
  final int status;
  final String createdAt;

  const Continent({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.createdAt
  });

  @override
  List<Object> get props => [id, name, image, status, createdAt];

}