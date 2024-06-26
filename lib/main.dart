import 'package:easy_localization/easy_localization.dart';
import 'package:exit_travil/core/helpers/helper_functions.dart';
import 'package:exit_travil/core/routers/routers.dart';
import 'package:exit_travil/core/styles/colors.dart';
import 'package:exit_travil/core/thems/them.dart';

import 'package:exit_travil/presentation/controller/app_bloc/app_cubit.dart';
import 'package:exit_travil/presentation/controller/favorite_cubit/cubit/favorite_cubit.dart';
import 'package:exit_travil/presentation/controller/home_bloc/home_cubit.dart';
import 'package:exit_travil/presentation/controller/photo_bloc/photo_cubit.dart';
import 'package:exit_travil/presentation/controller/place_cubit/place_cubit.dart';
import 'package:exit_travil/presentation/controller/search_cubit/cubit/search_cubit.dart';
import 'dart:io';
import 'package:exit_travil/presentation/ui/screens/navigation_screen.dart';
import 'package:exit_travil/presentation/ui/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'core/network/http_overriddes.dart';
import 'core/services/services_locator.dart';
import 'core/utlis/data.dart';

void main() async {
  ServicesLocator().init();
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await EasyLocalization.ensureInitialized();
  await readIds();
  getCurrentLange();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale("ar"), Locale("en")],
        path: "assets/translations",
        // <-- change the path of the translation files
        fallbackLocale: const Locale("ar"),
        startLocale: Locale(currentLang),
        child: const MyApp()),
  );
}

void getCurrentLange() {
  final String defaultLocale = Platform.localeName;
  currentLang = defaultLocale.split("_")[0];

  print(currentLang + " =======> lang");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: backgroundColor));
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavoriteCubit>(
            create: (BuildContext context) => sl<FavoriteCubit>()
              ..getFavorites()
              ..getFavoritesIds()..getFavoritePlaceIds()),

        BlocProvider<SearchCubit>(
            create: (BuildContext context) => sl<SearchCubit>()
              ),
        BlocProvider<AppCubit>(create: (BuildContext context) => AppCubit()),
        BlocProvider<PhotoCubit>(
            create: (BuildContext context) =>
                sl<PhotoCubit>()..getPhotos(page: 1, placId: 0)),
        BlocProvider<HomeCubit>(
            create: (BuildContext context) => sl<HomeCubit>()..getHomeData()),
        BlocProvider<PlaceCubit>(
            create: (BuildContext context) => sl<PlaceCubit>())
      ],
      child: MaterialApp(
        title: 'Ezy Travail',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: theme,
        
        // routerConfig: router,
        initialRoute: welcome,
        routes: {
          welcome: (context) => const WelcomeScreen(),
          navigation: (context) => NavigationScreen(),
        },
      ),
    );
  }

   /// This handles '/' and '/details'.

}
 final router = GoRouter(
   routes: [
     GoRoute(
       path: '/',
       builder: (_, __) => Scaffold(
         appBar: AppBar(title: const Text('Home Screen')),
       ),
       routes: [
         GoRoute(
           path: 'details',
           builder: (_, __) => Scaffold(
             appBar: AppBar(title: const Text('Details Screen')),
           ),
         ),
       ],
     ),
   ],
 );