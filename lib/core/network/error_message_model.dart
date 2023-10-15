import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final int statusCode;
  final String statusMessage;


 const ErrorMessageModel(
      {required this.statusCode, required this.statusMessage});





  @override

  List<Object?> get props => [statusCode , statusMessage];

}
