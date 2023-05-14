import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:exit_travil/core/utlis/api_constatns.dart';
import 'package:exit_travil/data/models/place_details_model.dart';

import 'package:exit_travil/domin/usecases/get_place_details_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utlis/enums.dart';
import '../../../domin/entities/place_details.dart';
import 'package:http/http.dart' as http;
part 'place_state.dart';

class PlaceCubit extends Cubit<PlaceState> {
  GetPlaceDetailsUseCase getPlaceDetailsUseCase;
  PlaceCubit(this.getPlaceDetailsUseCase) : super(const PlaceState());
  static PlaceCubit get(context) => BlocProvider.of<PlaceCubit>(context);
  getPlacesDetails({placeId}) async {
    emit(state.copyWith(placesStat: RequestState.loading));
    final result = await getPlaceDetailsUseCase.execute(placeId: placeId);

    result.fold(
        (l) => emit(
            state.copyWith(placesStat: RequestState.error, message: l.message)),
        (r) =>
            emit(state.copyWith(placesStat: RequestState.loaded, response: r)));
  }

  changIndexTab(newIndex) {
    emit(state.copyWith(currentIndex: newIndex));
  }

  getListPlacesData({cityId, index}) async {
    emit(state.copyWith(placesStat: RequestState.loading));
    var request = http.Request(
        'GET',
        Uri.parse(ApiConstants.getListPlaceDetailsPath +
            'cityId=${cityId}&index=$index'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);
      emit(state.copyWith(
          placesStat: RequestState.loaded,
          listPlaceDetails: List<PlaceDetails>.from(
              (jsonData as List).map((e) => PlaceDetailsModel.fromJson(e)))));
    } else {
      emit(state.copyWith(placesStat: RequestState.error));
    }
  }
}
