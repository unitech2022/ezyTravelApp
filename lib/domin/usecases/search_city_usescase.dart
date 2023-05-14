
import 'package:dartz/dartz.dart';
import 'package:exit_travil/domin/entities/place_details.dart';

import '../../core/failur/failure.dart';
import '../entities/city.dart';
import '../repostiory/base_repository.dart';

class SearchCityUseCase {
  final BaseRepository repository;

  SearchCityUseCase(this.repository);

  Future<Either<Failure, List<SearchResponse>>> execute({textSearch})async{

    return await repository.searchCity(textSearch: textSearch);
  }
}