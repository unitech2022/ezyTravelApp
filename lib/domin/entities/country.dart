import 'package:equatable/equatable.dart';

class Country extends Equatable{
  final int id;
  final int continentId;
  final String language;
  final String currency;
  final String name;
  final String image;
   final String capital;
  final int status;
  final String createdAt;

 const Country (
      {required this.id,
      required this.continentId,
      required this.language,
      required this.currency,
      required this.image,
      required this.name,
      required this.status,
      required this.capital,
      required this.createdAt});
      
        @override
       
        List<Object?> get props => [
          id,continentId ,language ,currency , name ,image ,status ,createdAt,capital
        ];

}
