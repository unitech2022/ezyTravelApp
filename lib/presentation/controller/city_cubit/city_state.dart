part of 'city_cubit.dart';

class CityState extends Equatable {
  final CityResponse? response;
  final RequestState citiesStat;
  final String message;
  final int currentIndex;

  const CityState(
      {this.response,
      this.citiesStat = RequestState.loading,
      this.message = "",
      this.currentIndex = 0});

  CityState copyWith(
      {final CityResponse? response,
      final RequestState? citiesStat,
      final String? message,
      final int? currentIndex}) {
    return CityState(
        response: response ?? this.response,
        citiesStat: citiesStat ?? this.citiesStat,
        message: message ?? this.message,
        currentIndex: currentIndex ?? this.currentIndex);
  }

  @override
  List<Object?> get props => [response, citiesStat, message, currentIndex];
}
