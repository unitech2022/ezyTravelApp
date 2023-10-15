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
    // TODO: implement initState
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
                      
                      SizedBox(
                        height: 20,
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
                                itemCount: state.homeModel!.continents.length,
                                controller: state.pageController,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              duration:
                                                  Duration(milliseconds: 100),
                                              reverseDuration:
                                                  Duration(milliseconds: 100),
                                              alignment: Alignment.center,
                                              curve: Curves.ease,
                                              type: PageTransitionType.fade,
                                              child: CitiesScreen(
                                                  continent: state.homeModel!
                                                      .continents[index])));
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
                        mostPopularCities: state.homeModel!.mostPopularCities,
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
                        mostPopularPlaces: state.homeModel!.mostPopularPlaces,
                      ),

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
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                        fit: BoxFit.cover,
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
