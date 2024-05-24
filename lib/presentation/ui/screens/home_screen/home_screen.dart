import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:exit_travil/core/helpers/helper_functions.dart';
import 'package:exit_travil/core/styles/colors.dart';
import 'package:exit_travil/core/utlis/api_constatns.dart';
import 'package:exit_travil/core/utlis/data.dart';
import 'package:exit_travil/domin/entities/continent.dart';
import 'package:exit_travil/presentation/controller/home_bloc/home_cubit.dart';
import 'package:exit_travil/presentation/ui/screens/cities_screen/cities_screen.dart';
import 'package:exit_travil/presentation/ui/screens/home_screen/components/list_most_popular_cities.dart';
import 'package:exit_travil/presentation/ui/screens/home_screen/components/list_most_popular_places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:ui' as ui;
import '../../../../core/utlis/enums.dart';
import '../../../../core/utlis/strings.dart';
import '../../../../core/widgets/cached_image_widget.dart';
import '../../../../core/widgets/texts.dart';
import '../../../../domin/entities/city.dart';
import '../../../controller/app_bloc/app_cubit.dart';
import '../../../controller/search_cubit/cubit/search_cubit.dart';
import '../places_screen/places_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _HomeScreenState extends State<HomeScreen> {
  FocusNode? focusNode;
  final _controller = TextEditingController();
  var currentPage = 0.0;

  @override
  void initState() {

    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStateGetHome>(
      builder: (context, state) {
        if (state.homeDataState == RequestState.loaded) {
          state.pageController!.addListener(() {
            HomeCubit.get(context)
                .changeCurrentPage(state.pageController!.page!);
          });
        }
        switch (state.homeDataState) {
          case RequestState.loading:
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          case RequestState.error:
            return Container(
              child: Text(
                state.message,
                style: GoogleFonts.cairo(
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 16)),
              ),
            );
          case RequestState.loaded:
          case RequestState.pagination:
            return Scaffold(
              backgroundColor: const Color(0xff1A1A1A),
              // resizeToAvoidBottomInset: false,
              body: Container(
                padding: const EdgeInsets.only(right: 12, left: 12, bottom: 50),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      /// container search
                      AppCubit.get(context).currentIndex == 1
                          ? BlocBuilder<SearchCubit, SearchState>(
                              builder: (context, state) {
                                return Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // ***  app
                                          Directionality(
                                            textDirection: ui.TextDirection.rtl,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AnimatedContainer(
                                                  // color: Colors.red,
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  width: focusNode!.hasFocus
                                                      ? 210
                                                      : 50,
                                                  child: TextField(
                                                    controller: _controller,
                                                    focusNode: focusNode,
                                                    onSubmitted: (value) {
                                                      focusNode!.unfocus();
                                                      SearchCubit.get(context)
                                                          .requestFocus(false);
                                                      _controller.clear();
                                                      SearchCubit.get(context)
                                                          .searchCities(
                                                              textSearch: "");
                                                      // HomeCubit.get(context)
                                                      //     .changeFocusFieldSearch(false);
                                                    },
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    cursorColor: Colors.white,
                                                    onChanged: (value) async {
                                                      if (_controller
                                                          .text.isNotEmpty) {
                                                        SearchCubit.get(context)
                                                            .searchCities(
                                                                textSearch:
                                                                    _controller
                                                                        .text
                                                                        .trim());
                                                      }
                                                    },
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            Strings.search.tr(),
                                                        hintStyle: GoogleFonts.cairo(
                                                            textStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .white38)),
                                                        prefixIcon: InkWell(
                                                          onTap: () {
                                                            if (!focusNode!
                                                                .hasFocus) {
                                                              focusNode!
                                                                  .requestFocus();
                                                              SearchCubit.get(
                                                                      context)
                                                                  .requestFocus(
                                                                      true);
                                                            } else {
                                                              focusNode!
                                                                  .unfocus();
                                                              SearchCubit.get(
                                                                      context)
                                                                  .requestFocus(
                                                                      false);
                                                            }
                                                          },
                                                          child: const Icon(
                                                              Icons.search,
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            35),
                                                    // color: Color.fromARGB(255, 20, 20, 20),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "EzyTravel",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      sizedWidth(5),
                                                      Image.asset(
                                                        "assets/images/newlogo2.png",
                                                        width: 60,
                                                        height: 60,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : SizedBox(),

                      Stack(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "القارات".tr(),
                                    style: GoogleFonts.cairo(
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            color: textColor,
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Directionality(
                                textDirection: ui.TextDirection.ltr,
                                child: Container(
                                  width: double.infinity,
                                  height: heightScreen(context) / 2,
                                  child: Stack(children: [
                                    CardScrollWidget(
                                      list: state.homeModel!.continents,
                                      currentPage: state.currentPage,
                                    ),
                                    Positioned.fill(
                                      child: PageView.builder(
                                        itemCount:
                                            state.homeModel!.continents.length,
                                        controller: state.pageController,
                                        physics: BouncingScrollPhysics(),
                                        reverse: true,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      duration: Duration(
                                                          milliseconds: 100),
                                                      reverseDuration: Duration(
                                                          milliseconds: 100),
                                                      alignment:
                                                          Alignment.center,
                                                      curve: Curves.ease,
                                                      type: PageTransitionType
                                                          .fade,
                                                      child: CitiesScreen(
                                                          continent: state
                                                                  .homeModel!
                                                                  .continents[
                                                              index])));
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              //  color: Colors.amber,
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ]),
                                ),
                              ),

                              /// ** most popular Cities
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "أشهر المدن السياحية".tr(),
                                    style: GoogleFonts.cairo(
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            color: textColor,
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              ListMostPopularCities(
                                mostPopularCities:
                                    state.homeModel!.mostPopularCities,
                              ),

                              /// ** most popular Places
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "أشهر المعالم السياحية".tr(),
                                    style: GoogleFonts.cairo(
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            color: textColor,
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              ListMostPopularPlaces(
                                mostPopularPlaces:
                                    state.homeModel!.mostPopularPlaces,
                              ),
                            ],
                          ),

                          /// LIST SEARCH CITES
                          _bodyWidget()
                        ],
                      )

                      // sizedHeight(10),
                      // Expanded(
                      //     child: Directionality(
                      //   textDirection: ui.TextDirection.rtl,
                      //   child: Row(
                      //     children: [
                      //       ExpandedContinent(
                      //           continent: state.homeModel!.continents[0]),
                      //       sizedWidth(10),
                      //       ExpandedContinent(
                      //           continent: state.homeModel!.continents[1]),
                      //     ],
                      //   ),
                      // )),
                      // sizedHeight(10),
                      // Expanded(
                      //     child: Directionality(
                      //   textDirection: ui.TextDirection.rtl,
                      //   child: Row(
                      //     children: [
                      //       ExpandedContinent(
                      //           continent: state.homeModel!.continents[2]),
                      //       sizedWidth(10),
                      //       ExpandedContinent(
                      //           continent: state.homeModel!.continents[3]),
                      //     ],
                      //   ),
                      // ))
                    ],
                  ),
                ),
              ),
            );
        }
      },
      listener: (BuildContext context, HomeStateGetHome state) {},
    );
  }

  Widget _bodyWidget() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        switch (state.citiesStat) {
          case RequestState.loaded:
            return state.response.isEmpty
                ? SizedBox()
                : Container(
                    color: backgroundColor,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: state.response.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          SearchResponse searchResponse = state.response[index];
                          return GestureDetector(
                            onTap: () {
                              pushPage(context,
                                  PlacesScreen(cityId: searchResponse.city.id));
                            },
                            child: Container(
                              height: 100,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey, width: .8))),
                              child: Row(children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: CachedNetworkImageWidget(
                                      image: searchResponse.country.image,
                                      width: 80,
                                      height: 80,
                                      iconError: const Icon(Icons.error)),
                                ),
                                // Align(
                                //   alignment: Alignment.bottomCenter,
                                //   child: Container(
                                //     height: 45,
                                //     decoration: const BoxDecoration(
                                //         gradient: LinearGradient(
                                //             begin: Alignment(0.0, -1.279),
                                //             end: Alignment(0.0, 0.618),
                                //             colors: [
                                //           Color(0x000d0d0d),
                                //           Color(0xff000000)
                                //         ],
                                //             stops: [
                                //           0.0,
                                //           1.0
                                //         ])),
                                //   ),
                                // ),
                                sizedWidth(30),
                                // Positioned(
                                //     right: 10, top: 4, child: IconFavorite(city: city)),
                                Expanded(
                                  child: Texts(
                                    title: getText(searchResponse.city.title),
                                    textColor: Colors.white,
                                    fontSize: 14,
                                    weight: FontWeight.normal,
                                  ),
                                )
                              ]),
                            ),
                          );
                        }),
                  );

          case RequestState.error:
            return SizedBox();

          case RequestState.pagination:
            return const SizedBox();
          case RequestState.loading:
            return SizedBox();
        }
      },
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 10.0;
  var verticalInset = 15.0;
  final List<Continent> list;

  CardScrollWidget({required this.list, this.currentPage});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2.3;

        List<Widget> cardList = [];

        for (var i = 0; i < list.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: ui.TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(40)),
              child: Container(
                decoration: BoxDecoration(color: Color(0xfff050505), boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      // Image.asset(list[i].image, fit: BoxFit.cover),
                      CachedNetworkImage(
                        imageUrl: ApiConstants.baseUrlImages + list[i].image,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.contain,
                        errorWidget: (context, url, error) => const Icon(
                          Icons.photo,
                          size: 50,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 50,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment(0.0, -1.279),
                                  end: Alignment(0.0, 0.618),
                                  colors: [
                                Color(0x000d0d0d),
                                Color(0xff000000)
                              ],
                                  stops: [
                                0.0,
                                1.0
                              ])),
                        ),
                      ),

                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(
                                  currentLang == "ar"
                                      ? list[i].name.split("*")[0]
                                      : list[i].name.split("*")[1],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return BlocBuilder<HomeCubit, HomeStateGetHome>(
          builder: (context, state) {
            return Stack(
              children: cardList,
            );
          },
        );
      }),
    );
  }
}

class ExpandedContinent extends StatelessWidget {
  final Continent continent;

  const ExpandedContinent({super.key, required this.continent});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        // Navigator.of(context).push(CustomPageRoute(
        //     child: CitiesScreen(continent: continent),
        //     direction: AxisDirection.right));

        // pushPage(
        //   context,
        //   CitiesScreen(continent: continent),
        // );

        Navigator.push(
            context,
            PageTransition(
                duration: Duration(milliseconds: 100),
                reverseDuration: Duration(milliseconds: 100),
                alignment: Alignment.center,
                curve: Curves.ease,
                type: PageTransitionType.fade,
                child: CitiesScreen(continent: continent)));
      },
      child: Hero(
        tag: "${continent.id}",
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                  child: Container(
                color: Color(0xff050505),
                child: CachedNetworkImage(
                  imageUrl: ApiConstants.baseUrlImages + continent.image,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) => const Icon(
                    Icons.photo,
                    size: 50,
                  ),
                ),
              )),
              sizedHeight(10),
              Text(
                currentLang == "ar"
                    ? continent.name.split("*")[0]
                    : continent.name.split("*")[1],
                style: GoogleFonts.cairo(
                    textStyle: const TextStyle(
                        fontSize: 14,
                        color: textColor,
                        fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
