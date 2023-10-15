import '../repostiory/base_repository.dart';

class AddFavoritePlaceUseCase{
  final BaseRepository repository;

  AddFavoritePlaceUseCase(this.repository);

  Future<bool> execute(List<String> ids)async{

    return await repository.addFavoritePlace(ids);
  }
}