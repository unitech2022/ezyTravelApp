import 'package:exit_travil/core/routers/routers.dart';
import 'package:exit_travil/presentation/ui/screens/navigation_screen.dart';
import 'package:exit_travil/presentation/ui/screens/welcome_screen.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter appRoute = GoRouter(routes: <RouteBase>[
  GoRoute(
    path:welcome,
    builder: (BuildContext context, GoRouterState state) {
      return  WelcomeScreen();
    },
  ),
  GoRoute(
    path:navigation,
    builder: (BuildContext context, GoRouterState state) {
      return  NavigationScreen();

    },
  ),

]);