import 'package:dartz/dartz.dart';
import 'package:exit_travil/domin/entities/city_response.dart';

import '../../core/failur/failure.dart';
import '../repostiory/base_repository.dart';

class GetCityDetailsUseCase{
  final BaseRepository repository;

  GetCityDetailsUseCase(this.repository);

  Future<Either<Failure,CityResponse>> execute({cityId})async{

    return await repository.getCityDetails(cityId: cityId);
  }
}