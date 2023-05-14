part of 'place_cubit.dart';

class PlaceState extends Equatable {
  final PlaceDetails? response;
  final List<PlaceDetails>? listPlaceDetails;
  final RequestState placesStat;
  final String message;
  final int currentIndex ;

  const PlaceState(
      {this.response,
      this.placesStat = RequestState.loading,
      this.listPlaceDetails,
      this.message = "",this.currentIndex=0});

       PlaceState copyWith(
      {final PlaceDetails? response,
      final RequestState? placesStat,
      final String? message,
      final List<PlaceDetails>? listPlaceDetails,
      final int? currentIndex}) {
    return PlaceState(
        response: response ?? this.response,
        placesStat: placesStat ?? this.placesStat,
        message: message ?? this.message,
         listPlaceDetails: listPlaceDetails ?? this.listPlaceDetails,
        currentIndex: currentIndex ?? this.currentIndex);
  }

  @override
  List<Object?> get props => [response, placesStat, message,currentIndex,listPlaceDetails];
}
