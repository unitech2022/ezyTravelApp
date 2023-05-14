

import 'package:dartz/dartz.dart';
import 'package:exit_travil/domin/entities/place_details.dart';

import '../../core/failur/failure.dart';
import '../repostiory/base_repository.dart';

class GetPlaceDetailsUseCase {
  final BaseRepository repository;

  GetPlaceDetailsUseCase(this.repository);

  Future<Either<Failure,PlaceDetails>> execute({placeId})async{

    return await repository.getPlaceDetails(placeId: placeId);
  }
}