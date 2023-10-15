
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseLocalDataSource {
  Future<List<String>> getFavorites();
  Future<bool> addFavorite(List<String> ids);


   Future<List<String>> getFavoritesPlace();
  Future<bool> addFavoritePlace(List<String> ids);
}


class LocalDataSource implements BaseLocalDataSource{
  

 @override
 Future<bool>  addFavorite(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
  
   return await prefs.setStringList("fav", ids);
  }

 @override
  Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
 
    return prefs.getStringList("fav")??[];
  }
  
  @override
  Future<bool> addFavoritePlace(List<String> ids)async {
   
    final prefs = await SharedPreferences.getInstance();
  
   return await prefs.setStringList("favplace", ids);
  }
  
  @override
  Future<List<String>> getFavoritesPlace() async{
  
    final prefs = await SharedPreferences.getInstance();
 
    return prefs.getStringList("favplace")??[];
  }
}
