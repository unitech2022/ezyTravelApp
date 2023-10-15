import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exit_travil/core/utlis/enums.dart';
import 'package:exit_travil/domin/usecases/get_fav_ids_usecase.dart';
import 'package:exit_travil/domin/usecases/get_favorits_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/statics/statics.dart';
import '../../../../data/models/city_model.dart';

import '../../../../domin/usecases/add_fav_ids_uses_case.dart';
import '../../../../domin/usecases/add_fav_place_ids_uses_case.dart';
import '../../../../domin/usecases/get_fav_place_ids_usecase.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  GetFavoriteIdsUseCase getFavoriteIdsUseCase;
  GetFavoritesUseCase getFavoritesUseCase;
  AddFavoriteUseCase addFavoriteUseCase;

  GetFavoritePlaceIdsUseCase getFavoritePlaceIdsUseCase;

  AddFavoritePlaceUseCase addFavoritePlaceUseCase;

  FavoriteCubit(
      this.getFavoriteIdsUseCase,
      this.addFavoriteUseCase,
      this.addFavoritePlaceUseCase,
      this.getFavoritePlaceIdsUseCase,
      this.getFavoritesUseCase)
      : super(const FavoriteState());
  static FavoriteCubit get(context) => BlocProvider.of<FavoriteCubit>(context);
  List<String> ids = [];
  getFavoritesIds() async {
    ids = Statics.ids;
    emit(FavoriteState(idsFav: ids));
  }

  changIndexTab(newIndex) {
    emit(state.copyWith(currentIndex: newIndex));
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

// ***
  List<String> idsPlace = [];
  getFavoritePlaceIds() async {
    idsPlace = Statics.idsPlace;
    emit(FavoriteState(idsFav: ids));
  }

  List<String> newIdsPlace = [];
  addFavoritePlace(id) {
    if (idsPlace.contains(id)) {
      idsPlace.remove(id);
      emit(const FavoriteState(addFav: false));
    } else {
      idsPlace.add(id);
      emit(const FavoriteState(addFav: true));
    }
    getFavoritePlaceIdsUseCase.execute().then((value) {
      if (value.contains(id)) {
        value.remove(id);
        emit(const FavoriteState(addFav: false));
      } else {
        value.add(id);
        emit(const FavoriteState(addFav: true));
      }
      addFavoritePlaceUseCase.execute(value).then((value) {
        getFavorites();
        emit(const FavoriteState(addFav: false));
      });
    });
  }

  getFavorites() async {
    String idLocalCity = "";
    String idLocalPlace = "";
    await getFavoritePlaceIdsUseCase.execute().then((value) async {
      if (value.isNotEmpty) {
        idLocalPlace = value.join("#");
        print(idLocalPlace + "idLocalPlaceidLocalPlace");
      } else {
        idLocalPlace = "0";
      }
    });
    await getFavoriteIdsUseCase.execute().then((value) async {
      if (value.isNotEmpty) {
        idLocalCity = value.join("#");
      } else {
        idLocalCity = "0";
      }

      emit(const FavoriteState(favState: RequestState.loading));
      final result = await getFavoritesUseCase.execute(
          ids: idLocalCity, idsPlace: idLocalPlace);

      result.fold((l) {
        print(l.message.toString() + "ihiihjioiiiii");
        emit(FavoriteState(favState: RequestState.error, message: l.message));
      }, (r) {
        // print(r.places.length.toString() + "success");
        emit(FavoriteState(favState: RequestState.loaded, favorites: r));
      });
    });
  }
}
