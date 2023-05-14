import 'package:dartz/dartz.dart';
import 'package:exit_travil/domin/entities/base_response.dart';
import 'package:exit_travil/domin/entities/country.dart';
import 'package:exit_travil/domin/entities/home.dart';
import 'package:exit_travil/domin/entities/city_response.dart';
import 'package:exit_travil/domin/entities/place_details.dart';
import '../../core/failur/failure.dart';
import '../entities/city.dart';
abstract class BaseRepository{
  Future<Either<Failure, Home>> getHomeData();

  Future<Either<Failure, BaseResponse>> getPhotos({page,placeId});

  Future<Either<Failure, List<Country>>> getCountriesByContinentId(continentId);

  Future<Either<Failure, CountryResponse>> getCitiesByCountryId({ countryId});
  Future<Either<Failure, CityResponse>> getCityDetails({cityId});

  Future<Either<Failure, PlaceDetails>> getPlaceDetails({placeId});

  Future<Either<Failure, List<City>>>getFavorites({ids});


  Future<Either<Failure, List<SearchResponse>>>searchCity({textSearch});

// local
   Future<bool> addFavorite(List<String> ids);
    Future<List<String>> getFavoritesIds();

}