part of 'country_cubit.dart';

class CountryState extends Equatable {
  final List<Country>? countries;
  final RequestState countryState;
  final RequestState citiesState;
  final CountryResponse? detailsCountry;
  final String message;
  final String messageCities;
  final int currentIndex;
   final int currentIndexPage;

  const CountryState(
      {this.countries,
      this.countryState = RequestState.loading,
      this.message = "",
      this.citiesState = RequestState.loading,
      this.detailsCountry,
      this.messageCities = "",
      this.currentIndexPage=0,
      this.currentIndex=1});

  CountryState copyWith(
      {final List<Country>? countries,
      final RequestState? countryState,
      final RequestState? citiesState,
      final CountryResponse? detailsCountry,
      final String? message,
      final String? messageCities,
       final int? currentIndexPage,
      final int? currentIndex}) {
    return CountryState(
        countries: countries ?? this.countries,
        countryState: countryState ?? this.countryState,
        citiesState: citiesState ?? this.citiesState,
        detailsCountry: detailsCountry ?? this.detailsCountry,
        message: message ?? this.message,
        messageCities: messageCities ?? this.messageCities,
    currentIndex: currentIndex?? this.currentIndex,
     currentIndexPage: currentIndexPage?? this.currentIndexPage
    );
  }

  @override
  List<Object?> get props => [
        countries,
        countryState,
        message,
        citiesState,
        detailsCountry,
        messageCities,
    currentIndex,
    currentIndexPage
      ];
}
