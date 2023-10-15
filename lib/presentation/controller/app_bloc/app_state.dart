part of 'app_cubit.dart';


abstract class AppState {}

class AppInitial extends AppState {}

class StartHome extends AppState {}

class ChangeIndex extends AppState {
  int currentIndex;

  ChangeIndex({this.currentIndex=0});

}
