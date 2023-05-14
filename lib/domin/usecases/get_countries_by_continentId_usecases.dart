import 'package:dartz/dartz.dart';

import '../../core/failur/failure.dart';
import '../entities/country.dart';
import '../repostiory/base_repository.dart';

class GetCountriesByContinentIdUseCase {
  final BaseRepository repository;

  GetCountriesByContinentIdUseCase(this.repository);

  Future<Either<Failure,List<Country>>> execute(continentId)async{

    return await repository.getCountriesByContinentId(continentId);
  }
}