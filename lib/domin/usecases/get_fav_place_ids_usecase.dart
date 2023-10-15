import '../repostiory/base_repository.dart';

class GetFavoritePlaceIdsUseCase {
  final BaseRepository repository;

  GetFavoritePlaceIdsUseCase(this.repository);

  Future<List<String>> execute() async {
    return await repository.getFavoritesIdsPlace();
  }
}
