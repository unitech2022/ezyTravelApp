part of 'home_cubit.dart';

// currentPage = state.homeModel!.continents.length - 1.0;
//           controller = (
//               initialPage: state.homeModel!.continents.length - 1);
//           controller!.addListener(() {
//             currentPage = controller!.page!;
//             HomeCubit.get(context).changeCurrentPage(currentPage);
class HomeStateGetHome extends Equatable {
  final Home? homeModel;
  final RequestState homeDataState;
  final  double currentPage;
  final String message;
  final  bool focusNode;

  final PageController? pageController;

const  HomeStateGetHome({ this.pageController,this.homeModel,
    this.homeDataState = RequestState.loading, this.message = "",this.focusNode=false,this.currentPage=0.0});

  HomeStateGetHome copyWith(
      {
         final PageController? pageController,
        final Home? homeModel,
        final RequestState? homeDataState,
        final String? message,
         final  double? currentPage,
        final  bool? focusNode,}) {
    return HomeStateGetHome(
        homeModel: homeModel ?? this.homeModel,
          pageController: pageController ?? this.pageController,
        homeDataState: homeDataState ?? this.homeDataState,
        currentPage: currentPage ?? this.currentPage,
        message: message ?? this.message,
        focusNode: focusNode ?? this.focusNode,
       );
  }

  @override
  List<Object?> get props => [homeModel, homeDataState, message,focusNode,currentPage,pageController];
}

