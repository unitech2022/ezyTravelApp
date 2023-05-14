import 'package:equatable/equatable.dart';
import 'package:exit_travil/core/utlis/data.dart';
import 'package:exit_travil/core/utlis/enums.dart';
import 'package:exit_travil/domin/usecases/get_cities_by_country_id_usecase.dart';
import 'package:exit_travil/domin/usecases/get_countries_by_continentId_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domin/entities/city.dart';
import '../../../domin/entities/country.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  GetCountriesByContinentIdUseCase getCountriesByContinentIdUseCase;
  GetCitiesByCountryIdUseCase getCitiesByCountryIdUseCase;

  static CountryCubit get(context) => BlocProvider.of<CountryCubit>(context);

  CountryCubit(
      this.getCountriesByContinentIdUseCase, this.getCitiesByCountryIdUseCase)
      : super(const CountryState());

  getCountriesByContinentId(continentId) async {
    emit(state.copyWith(countryState: RequestState.loading));
    final result = await getCountriesByContinentIdUseCase.execute(continentId);
    result.fold((l) {
      emit(
          state.copyWith(countryState: RequestState.error, message: l.message));
    }, (r) {
      if (r.isNotEmpty) {
        countries =r;
        changeIndexCountry(r.first.id);
        getCitiesByCountryId(countryId: r.first.id);

      }else{
        getCitiesByCountryId(countryId: 0);
      }
      emit(state.copyWith(countryState: RequestState.loaded, countries: r));
    });
  }

  getCitiesByCountryId({countryId}) async {
    emit(state.copyWith(citiesState: RequestState.loading));
    final result =
        await getCitiesByCountryIdUseCase.execute(countryId: countryId);

    result.fold(
        (l) => emit(state.copyWith(
            citiesState: RequestState.error, messageCities: l.message)),
        (r) => emit(state.copyWith(
            citiesState: RequestState.loaded, detailsCountry: r)));
  }

  changeIndexCountry(newIndex) {
    emit(state.copyWith(currentIndex: newIndex));
  }

  changeIndexCountryPage(newIndex) {
    emit(state.copyWith(currentIndexPage: newIndex));
  }
}
