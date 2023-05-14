import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exit_travil/core/utlis/enums.dart';
import 'package:exit_travil/domin/usecases/get_fav_ids_usecase.dart';
import 'package:exit_travil/domin/usecases/get_favorits_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/statics/statics.dart';
import '../../../../domin/entities/city.dart';
import '../../../../domin/usecases/add_fav_ids_uses_case.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  GetFavoriteIdsUseCase getFavoriteIdsUseCase;
  GetFavoritesUseCase getFavoritesUseCase;
  AddFavoriteUseCase addFavoriteUseCase;

  FavoriteCubit(this.getFavoriteIdsUseCase, this.addFavoriteUseCase,
      this.getFavoritesUseCase)
      : super(const FavoriteState());
  static FavoriteCubit get(context) => BlocProvider.of<FavoriteCubit>(context);
  List<String> ids = [];
  getFavoritesIds() async {
    ids = Statics.ids;
    emit(FavoriteState(idsFav: ids));
  }

  List<String> newIds = [];
  addFavorite(id) {
    if (ids.contains(id)) {
      ids.remove(id);
      emit(const FavoriteState(addFav: false));
    } else {
      ids.add(id);
      emit(const FavoriteState(addFav: true));
    }
    getFavoriteIdsUseCase.execute().then((value) {
      if (value.contains(id)) {
        value.remove(id);
        emit(const FavoriteState(addFav: false));
      } else {
        value.add(id);
        emit(const FavoriteState(addFav: true));
      }
      addFavoriteUseCase.execute(value).then((value) {
        getFavorites();
         emit(const FavoriteState(addFav: false));
      });
    });
  }

  getFavorites() async {
    String idLocal = "";
    await getFavoriteIdsUseCase.execute().then((value) async {
      if (value.isNotEmpty) {
        idLocal = value.join("#");
      }

      emit(const FavoriteState(favState: RequestState.loading));
      final result = await getFavoritesUseCase.execute(ids: idLocal);
     
      result.fold(
          (l) => emit(
              FavoriteState(favState: RequestState.error, message: l.message)),
          (r) =>
              emit(FavoriteState(favState: RequestState.loaded, favorites: r)));
    });
  }
}
