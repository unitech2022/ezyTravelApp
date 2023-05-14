import 'package:equatable/equatable.dart';
import 'package:exit_travil/domin/entities/city_response.dart';
import 'package:exit_travil/domin/usecases/get_city_details_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utlis/enums.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  GetCityDetailsUseCase getCityDetailsUseCase;

  CityCubit(this.getCityDetailsUseCase) : super(const CityState());

  static CityCubit get(context) => BlocProvider.of<CityCubit>(context);

  getCitiesDetails({cityId}) async {
    emit(state.copyWith(citiesStat: RequestState.loading));
    final result = await getCityDetailsUseCase.execute(cityId: cityId);

    result.fold((l) {
      emit(state.copyWith(citiesStat: RequestState.error, message: l.message));
    }, (r) {
      print(r.videos.length.toString() + " ======> videos");
      emit(state.copyWith(citiesStat: RequestState.loaded, response: r));
    });
  }

  changIndexTab(newIndex) {
    emit(state.copyWith(currentIndex: newIndex));
  }
}
