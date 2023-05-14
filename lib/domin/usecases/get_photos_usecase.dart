
import 'package:dartz/dartz.dart';
import 'package:exit_travil/domin/entities/base_response.dart';

import '../../core/failur/failure.dart';
import '../entities/home.dart';
import '../repostiory/base_repository.dart';

class GetPhotosUseCase {
  final BaseRepository repository;

  GetPhotosUseCase(this.repository);

  Future<Either<Failure,BaseResponse>> execute({page,placeId})async{

    return await repository.getPhotos(page: page,placeId: placeId);
  }
}