import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routers/routers.dart';
import '../statics/statics.dart';
import '../utlis/data.dart';

pushPage(context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

pop(context) {
  Navigator.pop(context);
}

pushPageRoutName(context, route) {
  Navigator.pushNamed(
    context,
    route,
  );
}

pushPageRoutNameReplaced(context, route) {
  Navigator.pushReplacementNamed(
    context,
    route,
  );
}

widthScreen(context) => MediaQuery.of(context).size.width;

heightScreen(context) => MediaQuery.of(context).size.height;

SizedBox sizedHeight(double height) => SizedBox(
      height: height,
    );
SizedBox sizedWidth(double width) => SizedBox(
      width: width,
    );

readIds() async {
  final prefs = await SharedPreferences.getInstance();

  Statics.ids = prefs.getStringList("fav") ?? [];
}

class CustomCacheManager {
  static const key = 'customCacheKey';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 15),
      maxNrOfCacheObjects: 20,
    ),
  );
}

String getText(String text) {
  if (text.contains("*")) {
    return currentLang == "ar" ? text.split("*")[0] : text.split("*")[1];
  } else
   return text;
}
