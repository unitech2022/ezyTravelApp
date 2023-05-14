import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:exit_travil/domin/usecases/get_home_data_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../core/utlis/enums.dart';
import '../../../domin/entities/home.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeStateGetHome> {

  GetHomeDataUseCase getHomeDataUseCase;
  HomeCubit(this.getHomeDataUseCase) : super(const HomeStateGetHome());

 static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

  getHomeData()async {
    emit(const HomeStateGetHome(homeDataState: RequestState.loading));
    final result=await getHomeDataUseCase.execute();
    result.fold((l) => emit(HomeStateGetHome(homeDataState: RequestState.error,
    message: l.message)),
            (r) => emit(HomeStateGetHome(homeDataState: RequestState.loaded,
               homeModel: r )));

  }
  changeFocusFieldSearch(bool focusNew){

    bool focus = focusNew;
    emit(state.copyWith(focusNode: focus));

  }
}
