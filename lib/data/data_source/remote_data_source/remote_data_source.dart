import 'package:dio/dio.dart';
import 'package:exit_travil/core/utlis/api_constatns.dart';
import 'package:exit_travil/data/models/country_model.dart';
import 'package:exit_travil/data/models/home_model.dart';
import 'package:exit_travil/data/models/place_details_model.dart';
import 'package:exit_travil/data/models/response_city_model.dart';
import 'package:exit_travil/domin/entities/base_response.dart';
import '../../../core/network/error_message_model.dart';
import '../../../domin/entities/city.dart';
import '../../../domin/entities/home.dart';
import '../../models/city_model.dart';
import '../../models/response_country.dart';
import '../../models/response_photos.dart';

abstract class BaseRemoteDataSource {
  Future<Home> getHome();
  Future<BaseResponse> getPhotos({page, placeId});
  Future<List<CountryModel>> getCountriesByContinentId(continentId);
  Future<ResponseCountryModel> getCitiesByCountryId({page, countryId});
  Future<ResponseCityModel> getCityDetails({cityId});
  Future<PlaceDetailsModel> getPlaceDetails({placeId});
  Future<FavResponse> getFavorites(ids, idsPlace);
  Future<List<SearchResponse>> searchCity(textSearch);
}

class RemoteDataSource implements BaseRemoteDataSource {
  @override
  Future<Home> getHome() async {
    final response = await Dio().get(
      ApiConstants.getDataHomePath,
    );
    if (response.statusCode == 200) {
      return HomeModel.fromJson(response.data);
    } else {
      throw ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: "حدث خطأ, حاول مرة أخرى");
    }
  }

  @override
  Future<BaseResponse> getPhotos({page, placeId}) async {
    final response = await Dio().get(
      "${ApiConstants.getPhotosPath}page=$page&placeId=$placeId",
    );
    print(response.statusCode.toString() + "getPhotos");
    if (response.statusCode == 200) {
      return ResponsePhotos.fromJson(response.data);
    } else {
      throw ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: "حدث خطأ, حاول مرة أخرى");
    }
  }

  @override
  Future<List<CountryModel>> getCountriesByContinentId(continentId) async {
    final response = await Dio().get(
      "${ApiConstants.getCountriesByContinentIdPath}continentId=$continentId",
    );

    if (response.statusCode == 200) {
      return List<CountryModel>.from(
          (response.data as List).map((e) => CountryModel.fromJson(e)));
    } else {
      throw ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: "حدث خطأ, حاول مرة أخرى");
    }
  }

  @override
  Future<ResponseCountryModel> getCitiesByCountryId({page, countryId}) async {
    final response = await Dio().get(
      "${ApiConstants.getCitiesByCountryIdPath}page=$page&countryId=$countryId",
    );
    if (response.statusCode == 200) {
      return ResponseCountryModel.fromJson(response.data);
    } else {
      throw ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: "حدث خطأ, حاول مرة أخرى");
    }
  }

  @override
  Future<ResponseCityModel> getCityDetails({cityId}) async {
    final response = await Dio().get(
      "${ApiConstants.getCityDetailsPath}cityId=$cityId",
    );
    if (response.statusCode == 200) {
      return ResponseCityModel.fromJson(response.data);
    } else {
      throw ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: "حدث خطأ, حاول مرة أخرى");
    }
  }

  @override
  Future<PlaceDetailsModel> getPlaceDetails({placeId}) async {
    final response = await Dio().get(
      "${ApiConstants.getPlaceDetailsPath}placeId=$placeId",
    );
    if (response.statusCode == 200) {
      return PlaceDetailsModel.fromJson(response.data);
    } else {
      throw ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: "حدث خطأ, حاول مرة أخرى");
    }
  }

  @override
  Future<FavResponse> getFavorites(ids, idsPlace) async {
    final response = await Dio().get(
      "${ApiConstants.getFavoritesPath}ids=$ids&idsPlace=$idsPlace"
          .replaceAll("#", "%23"),
    );
    print(response.statusCode.toString() + " ========> getFavorites");
    if (response.statusCode == 200) {
      return FavResponse.fromJson(response.data);
    } else {
      throw ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: "حدث خطأ, حاول مرة أخرى");
    }
  }

  @override
  Future<List<SearchResponse>> searchCity(textSearch) async {
    final response = await Dio()
        .get("${ApiConstants.searchCitiesPath}textSearch=$textSearch");
    if (response.statusCode == 200) {
      return List<SearchResponse>.from(
          (response.data as List).map((e) => SearchResponse.fromJson(e)));
    } else {
      throw ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: "حدث خطأ, حاول مرة أخرى");
    }
  }
}
