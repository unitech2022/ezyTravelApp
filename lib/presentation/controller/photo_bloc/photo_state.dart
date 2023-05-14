import 'package:equatable/equatable.dart';
import 'package:exit_travil/domin/entities/base_response.dart';

import '../../../core/utlis/enums.dart';




class PhotoState extends Equatable {
  final BaseResponse? response;
  final RequestState photosStat;
  final String message;

const  PhotoState({this.response,
    this.photosStat = RequestState.loading, this.message = ""});

  @override
  List<Object?> get props => [response, photosStat, message];
}