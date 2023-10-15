import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exit_travil/domin/entities/city.dart';
import 'package:exit_travil/domin/usecases/search_city_usescase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utlis/enums.dart';


part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCityUseCase searchCityUseCase;
  SearchCubit(this.searchCityUseCase) : super(const SearchState());
  static SearchCubit get(context) => BlocProvider.of<SearchCubit>(context);

  searchCities({textSearch}) async {
    emit(const SearchState(citiesStat: RequestState.loading));
    // await Future.delayed(const Duration(milliseconds: 5000));
    final result = await searchCityUseCase.execute(textSearch: textSearch);

    result.fold(
        (l) => emit(
            SearchState(citiesStat: RequestState.error, message: l.message)),
        (r) => emit(SearchState(citiesStat: RequestState.loaded, response: r)));
  }

  requestFocus(bool focus) {
    emit(state.copyWith(hasFocus: focus));
  }
}
