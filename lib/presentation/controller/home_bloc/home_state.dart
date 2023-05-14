part of 'home_cubit.dart';


class HomeStateGetHome extends Equatable {
  final Home? homeModel;
  final RequestState homeDataState;
  final String message;
  final  bool focusNode;

const  HomeStateGetHome({this.homeModel,
    this.homeDataState = RequestState.loading, this.message = "",this.focusNode=false});

  HomeStateGetHome copyWith(
      {
        final Home? homeModel,
        final RequestState? homeDataState,
        final String? message,
        final  bool? focusNode,}) {
    return HomeStateGetHome(
        homeModel: homeModel ?? this.homeModel,
        homeDataState: homeDataState ?? this.homeDataState,
        message: message ?? this.message,
        focusNode: focusNode ?? this.focusNode,
       );
  }

  @override
  List<Object?> get props => [homeModel, homeDataState, message,focusNode];
}

