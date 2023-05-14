import 'package:dartz/dartz.dart';
import 'package:exit_travil/domin/entities/base_response.dart';
import '../../core/failur/failure.dart';
import '../entities/city.dart';
import '../repostiory/base_repository.dart';

class GetCitiesByCountryIdUseCase{
  final BaseRepository repository;

  GetCitiesByCountryIdUseCase(this.repository);

  Future<Either<Failure,CountryResponse>> execute({countryId})async{

    return await repository.getCitiesByCountryId(countryId: countryId);
  }
}