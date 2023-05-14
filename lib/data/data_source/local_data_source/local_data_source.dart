import 'package:flutter_phoenix/generated/i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseLocalDataSource {
  Future<List<String>> getFavorites();
  Future<bool> addFavorite(List<String> ids);
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
}
