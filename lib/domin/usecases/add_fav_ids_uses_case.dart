import '../repostiory/base_repository.dart';

class AddFavoriteUseCase{
  final BaseRepository repository;

  AddFavoriteUseCase(this.repository);

  Future<bool> execute(List<String> ids)async{

    return await repository.addFavorite(ids);
  }
}