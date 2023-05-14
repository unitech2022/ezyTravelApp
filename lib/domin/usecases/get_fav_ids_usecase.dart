import '../repostiory/base_repository.dart';

class GetFavoriteIdsUseCase {
  final BaseRepository repository;

  GetFavoriteIdsUseCase(this.repository);

  Future<List<String>> execute() async {
    return await repository.getFavoritesIds();
  }
}
