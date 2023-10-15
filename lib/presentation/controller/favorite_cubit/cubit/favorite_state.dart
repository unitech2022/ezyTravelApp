part of 'favorite_cubit.dart';

class FavoriteState extends Equatable {
  final List<String> idsFav;
  final RequestState favState;
  final FavResponse? favorites;
  final bool addFav;
  final String message ;
    final int currentIndex;

  const FavoriteState(
      {this.idsFav = const [],
      this.addFav = false,
      this.favState = RequestState.loading,
      this.currentIndex=0,
      this.favorites ,this.message= ""});

  FavoriteState copyWith({
    List<String>? idsFav,
    bool? addFav,
    final RequestState? favState,
    final int? currentIndex,
      final String? message 
  }) {
    return FavoriteState(
        idsFav: idsFav ?? this.idsFav,
        addFav: addFav ?? this.addFav,
        favState: favState ?? this.favState,
        favorites: favorites ?? this.favorites,
         currentIndex: currentIndex ?? this.currentIndex,
        message: message??this.message);
  }

  @override
  List<Object?> get props => [idsFav, addFav, favState, favorites,currentIndex];
}
