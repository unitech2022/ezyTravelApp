import 'package:dartz/dartz.dart';

import '../../core/failur/failure.dart';
import '../../data/models/city_model.dart';
import '../entities/city.dart';
import '../repostiory/base_repository.dart';

class GetFavoritesUseCase {
  final BaseRepository repository;

  GetFavoritesUseCase(this.repository);

  Future<Either<Failure, FavResponse>> execute({ids, idsPlace}) async {
    return await repository.getFavorites(ids: ids,idsPlace: idsPlace);
  }
}
