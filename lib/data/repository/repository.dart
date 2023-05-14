import 'package:dartz/dartz.dart';
import 'package:exit_travil/core/failur/failure.dart';
import 'package:exit_travil/data/data_source/local_data_source/local_data_source.dart';
import 'package:exit_travil/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:exit_travil/domin/entities/base_response.dart';
import 'package:exit_travil/domin/entities/city.dart';
import 'package:exit_travil/domin/entities/country.dart';
import 'package:exit_travil/domin/entities/home.dart';
import 'package:exit_travil/domin/entities/city_response.dart';
import 'package:exit_travil/domin/entities/place_details.dart';
import 'package:exit_travil/domin/repostiory/base_repository.dart';
import '../../core/error/exceptions.dart';

class Repository extends BaseRepository {
  final BaseRemoteDataSource baseRemoteDataSource;
  final BaseLocalDataSource baseLocalDataSource;

  Repository(this.baseRemoteDataSource, this.baseLocalDataSource);

  @override
  Future<Either<Failure, Home>> getHomeData() async {
    final result = await baseRemoteDataSource.getHome();

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> getPhotos({page, placeId}) async {
    // TODO : implement getPhotos
    final result =
        await baseRemoteDataSource.getPhotos(page: page, placeId: placeId);

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Country>>> getCountriesByContinentId(
      continentId) async {
    // TODO: implement getCountriesByContinentId
    final result =
        await baseRemoteDataSource.getCountriesByContinentId(continentId);

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, CountryResponse>> getCitiesByCountryId(
      {page, countryId}) async {
    // TODO: implement getCountriesByContinentId
    final result = await baseRemoteDataSource.getCitiesByCountryId(
        countryId: countryId, page: page);

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, CityResponse>> getCityDetails({cityId}) async {

    final result = await baseRemoteDataSource.getCityDetails(cityId: cityId);

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, PlaceDetails>> getPlaceDetails({placeId}) async {
    final result = await baseRemoteDataSource.getPlaceDetails(placeId: placeId);

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<bool> addFavorite(List<String> ids) {
    return baseLocalDataSource.addFavorite(ids);
  }

  @override
  Future<List<String>> getFavoritesIds() {
    return baseLocalDataSource.getFavorites();
  }
  
  @override
  Future<Either<Failure, List<City>>> getFavorites({ids}) async{
    // TODO: implement getFavorites
    final result = await baseRemoteDataSource.getFavorites(ids);

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
  
  @override
  Future<Either<Failure, List<SearchResponse>>> searchCity({textSearch}) async{
    // TODO: implement searchCity
    final result = await baseRemoteDataSource.searchCity(textSearch);

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
