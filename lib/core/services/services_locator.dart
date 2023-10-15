import 'package:exit_travil/data/data_source/local_data_source/local_data_source.dart';
import 'package:exit_travil/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:exit_travil/data/repository/repository.dart';
import 'package:exit_travil/domin/repostiory/base_repository.dart';
import 'package:exit_travil/domin/usecases/add_fav_ids_uses_case.dart';
import 'package:exit_travil/domin/usecases/get_cities_by_country_id_usecase.dart';
import 'package:exit_travil/domin/usecases/get_city_details_use_case.dart';
import 'package:exit_travil/domin/usecases/get_countries_by_continentId_usecases.dart';
import 'package:exit_travil/domin/usecases/get_fav_ids_usecase.dart';
import 'package:exit_travil/domin/usecases/get_favorits_usecase.dart';
import 'package:exit_travil/domin/usecases/get_home_data_usecase.dart';
import 'package:exit_travil/domin/usecases/get_photos_usecase.dart';
import 'package:exit_travil/domin/usecases/get_place_details_usecase.dart';
import 'package:exit_travil/domin/usecases/search_city_usescase.dart';
import 'package:exit_travil/presentation/controller/city_cubit/city_cubit.dart';
import 'package:exit_travil/presentation/controller/favorite_cubit/cubit/favorite_cubit.dart';
import 'package:exit_travil/presentation/controller/home_bloc/home_cubit.dart';
import 'package:exit_travil/presentation/controller/photo_bloc/photo_cubit.dart';
import 'package:exit_travil/presentation/controller/place_cubit/place_cubit.dart';
import 'package:exit_travil/presentation/controller/search_cubit/cubit/search_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../domin/usecases/add_fav_place_ids_uses_case.dart';
import '../../domin/usecases/get_fav_place_ids_usecase.dart';
import '../../presentation/controller/country_bloc/country_cubit.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// bloc
    sl.registerFactory(() => HomeCubit(sl()));
    sl.registerFactory(() => PhotoCubit(sl()));
    sl.registerFactory(() => CountryCubit(sl(), sl()));
    sl.registerFactory(() => CityCubit(sl()));
    sl.registerFactory(() => PlaceCubit(sl()));
    sl.registerFactory(() => FavoriteCubit(sl(), sl(), sl(),sl(),sl()));
    sl.registerFactory(() => SearchCubit(sl()));

    /// use Cases
    sl.registerLazySingleton(() => GetHomeDataUseCase(sl()));
    sl.registerLazySingleton(() => GetCountriesByContinentIdUseCase(sl()));
    sl.registerLazySingleton(() => GetCitiesByCountryIdUseCase(sl()));
    sl.registerLazySingleton(() => GetPhotosUseCase(sl()));
    sl.registerLazySingleton(() => GetCityDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetPlaceDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetFavoritesUseCase(sl()));
    sl.registerLazySingleton(() => GetFavoriteIdsUseCase(sl()));
    sl.registerLazySingleton(() => AddFavoriteUseCase(sl()));
    sl.registerLazySingleton(() => GetFavoritePlaceIdsUseCase(sl()));
    sl.registerLazySingleton(() => AddFavoritePlaceUseCase(sl()));
    sl.registerLazySingleton(() => SearchCityUseCase(sl()));

    /// repository
    sl.registerLazySingleton<BaseRepository>(() => Repository(sl(), sl()));

    ///data source
    sl.registerLazySingleton<BaseRemoteDataSource>(() => RemoteDataSource());

    sl.registerLazySingleton<BaseLocalDataSource>(() => LocalDataSource());
  }
}
