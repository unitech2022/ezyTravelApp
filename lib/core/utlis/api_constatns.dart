class ApiConstants {
  static const baseUrl ="https://webapi.exittravel.app";
  // static const baseUrl = "https://638d-154-183-195-186.ngrok-free.app";
  static const baseUrlImages = "$baseUrl/images/";
  static const baseUrlVideos = "$baseUrl/videos/";
  static const getDataHomePath = "$baseUrl/home/get-home";
  static const getPhotosPath = "$baseUrl/photos/get-photos-by-placeId?";
  static const getCountriesByContinentIdPath =
      "$baseUrl/countries/get-countries-by-cont-Id?";
  static const getCitiesByCountryIdPath =
      "$baseUrl/cities/git-cities-byCountryId?";

  static const getCityDetailsPath = "$baseUrl/cities/get-city-details?";
  static const getPlaceDetailsPath = "$baseUrl/places/get-placeDetails?";

  static const searchCitiesPath = "$baseUrl/cities/search_city?";

  static const getFavoritesPath = "$baseUrl/Favorite/get-favorites?";
  static String imageUrl(path) => "$baseUrlImages/$path";

  static const getListPlaceDetailsPath = "$baseUrl/places/get-places-details?";
}
