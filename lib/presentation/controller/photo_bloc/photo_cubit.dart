import 'package:exit_travil/domin/usecases/get_photos_usecase.dart';
import 'package:exit_travil/presentation/controller/photo_bloc/photo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utlis/enums.dart';

class PhotoCubit extends Cubit<PhotoState> {
  GetPhotosUseCase getPhotosUseCase;
  PhotoCubit(this.getPhotosUseCase) : super(const PhotoState());

  static PhotoCubit get(context) => BlocProvider.of<PhotoCubit>(context);
  List<Object> items = [];
  int totalPages = 0;
  getPhotos({page,placId=0}) async {
    if (page == 1) {
      emit(const PhotoState(photosStat: RequestState.loading));
    } else {
      emit(const PhotoState(photosStat: RequestState.pagination));
    }
    final result = await getPhotosUseCase.execute(page:page,placeId: placId);
    result.fold(
        (l) => emit(
            PhotoState(photosStat: RequestState.error, message: l.message)),
        (r) {
      if (page == 1) {
        items = r.items;
        totalPages = r.totalPages;
        emit(PhotoState(photosStat: RequestState.loaded, response: r));
      } else {
        items.addAll(r.items);
        // BaseResponse baseResponse = BaseResponse(
        //     currentPage: r.currentPage, totalPages: r.totalPages, items: items);
        totalPages = r.totalPages;
       
        emit(PhotoState(photosStat: RequestState.loaded, response: r));
      }
    });
  }

}
