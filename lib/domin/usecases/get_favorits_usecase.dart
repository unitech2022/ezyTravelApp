import 'package:dartz/dartz.dart';

import '../../core/failur/failure.dart';
import '../entities/city.dart';
import '../repostiory/base_repository.dart';

class GetFavoritesUseCase {
  final BaseRepository repository;

  GetFavoritesUseCase(this.repository);

  Future<Either<Failure, List<City>>> execute({ids}) async {
    return await repository.getFavorites(ids: ids);
  }
}
