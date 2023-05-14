part of 'search_cubit.dart';

 class SearchState extends Equatable {

  final List<SearchResponse> response;
  final RequestState citiesStat;
  final String message;
  final int currentIndex;
  final bool hasFocus;

  const SearchState(
      {this.response= const [],
      this.citiesStat = RequestState.pagination,
      this.message = "",
      this.hasFocus=false,
      this.currentIndex = 0});


 SearchState copyWith(
      {
      final bool? hasFocus}) {
    return SearchState(
        hasFocus: hasFocus ?? this.hasFocus,
       );
  }

  @override
  List<Object?> get props => [response, citiesStat, message, currentIndex,hasFocus];
}

