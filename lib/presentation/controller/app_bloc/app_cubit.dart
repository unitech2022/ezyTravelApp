import 'package:exit_travil/core/helpers/helper_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routers/routers.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context)=> BlocProvider.of<AppCubit>(context);

  startNavigationPage(context) {
    Future.delayed(const Duration(seconds: 3), () {
      pushPageRoutNameReplaced(context, navigation);
      emit(StartHome());
    });
  }

  int currentIndex = 1;
  changeIndexNavigation(int newIndex) {
    currentIndex = newIndex;
    emit(ChangeIndex());
  }
}
