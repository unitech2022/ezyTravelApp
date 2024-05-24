import 'package:carousel_slider/carousel_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:exit_travil/core/widgets/cached_image_widget.dart';
import 'package:exit_travil/domin/entities/weather.dart';
import 'package:exit_travil/presentation/controller/city_cubit/city_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:ui' as ui;
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/sizing.dart';
import '../../../../core/utlis/enums.dart';
import '../../../../core/utlis/strings.dart';
import '../../../../core/widgets/texts.dart';
import '../../../../domin/entities/city.dart';
import '../../../../domin/entities/city_response.dart';
import '../../../../domin/entities/place.dart';
import '../../../controller/favorite_cubit/cubit/favorite_cubit.dart';
import '../../../controller/place_cubit/place_cubit.dart';
import '../cities_screen/cities_screen.dart';
import '../place_details/componts/indicator_widget.dart';
import '../place_details/componts/slider_widget.dart';
import '../place_details/place_details.dart';
import 'componts/list_photos.dart';
import 'componts/list_places_grid_widget.dart';

class PlacesScreen extends StatefulWidget {
  final int cityId;

  PlacesScreen({required this.cityId});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  List<Widget> screens = [];
  PageController controllerPage = PageController(initialPage: 0);
  @override
  void dispose() {
    super.dispose();
    controllerPage.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<CityCubit>()..getCitiesDetails(cityId: widget.cityId),
      child: BlocConsumer<CityCubit, CityState>(
        listener: (context, state) {
          if (state.citiesStat == RequestState.loaded) {
            screens = [
              PlacesListWidget(state.response!.places, []),
              ListPhotos(state.response!),
            ];
          }
        },
        builder: (context, state) {
          switch (state.citiesStat) {
            case RequestState.loading:
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              );
            case RequestState.loaded:
              return Scaffold(
                body: Column(
                  children: [
                    DetailsCityWidget(
                      response: state.response!,
                      weather: state.response!.weather,
                    ),
                    sizedHeight(10),
                    // Material(
                    //   color: backgroundColor,
                    //   child: TabBar(
                    //     labelColor: Colors.black,
                    //
                    //
                    //     unselectedLabelColor: Colors.grey,
                    //
                    //
                    //     indicator: ShapeDecoration(
                    //
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(25)),
                    //         color: Colors.white),
                    //     indicatorColor: Colors.white,
                    //     labelStyle: GoogleFonts.cairo(
                    //         fontSize: 16, fontWeight: FontWeight.bold),
                    //     tabs: const [
                    //       Tab(
                    //         text: Strings.photos,
                    //         height: 40,
                    //       ),
                    //       Tab(
                    //         text: Strings.places,
                    //         height: 40,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    //
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          ContainerTab(
                            height: 30,
                            icon: "assets/icons/map.svg",
                            textColor: state.currentIndex == 0
                                ? Colors.black
                                : Colors.white70,
                            backgroundColor: state.currentIndex == 0
                                ? Colors.white
                                : Color.fromARGB(255, 72, 71, 71)
                                    .withOpacity(.5),
                            title: Strings.places.tr(),
                            onTap: () {
                              controllerPage.jumpToPage(0);
                              CityCubit.get(context).changIndexTab(0);
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ContainerTab(
                            height: 22,
                            icon: "assets/icons/photos.svg",
                            textColor: state.currentIndex == 1
                                ? Colors.black
                                : Colors.white70,
                            backgroundColor: state.currentIndex == 1
                                ? Colors.white
                                : Color.fromARGB(255, 72, 71, 71)
                                    .withOpacity(.5),
                            title: Strings.photos.tr(),
                            onTap: () {
                              controllerPage.jumpToPage(1);
                              CityCubit.get(context).changIndexTab(1);
                            },
                          ),
                        ],
                      ),
                    ),
                    sizedHeight(10),
                    Expanded(
                        child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: controllerPage,
                      onPageChanged: (value) {
                        CityCubit.get(context).changIndexTab(value);
                      },
                      children: screens,
                    ))
                    //  state.currentIndex == 1
                    //     ? ListPhotos(
                    //         state.response!.photos as List<PhotoModel>)
                    //     : PlacesListWidget(state.response!.places))
                  ],
                ),
              );
            case RequestState.error:
              return SizedBox(
                height: 100,
                child: Center(
                    child: Texts(
                  title: state.message,
                  textColor: textColor,
                  fontSize: 18,
                  weight: FontWeight.bold,
                )),
              );
            case RequestState.pagination:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

class ContainerTab extends StatelessWidget {
  final String icon;
  final String title;
  final void Function() onTap;
  final double height;
  final Color textColor, backgroundColor;
  ContainerTab(
      {required this.title,
      required this.onTap,
      required this.textColor,
      required this.height,
      required this.backgroundColor,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: backgroundColor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: GoogleFonts.cairo(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              sizedWidth(10),
              SvgPicture.asset(
                icon,
                color: textColor,
                // width: 28,
                height: height,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DetailsCityWidget extends StatelessWidget {
  final CityResponse response;
  final Weather weather;

  const DetailsCityWidget(
      {super.key, required this.response, required this.weather});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        children: [
          CachedNetworkImageWidget(
              image: response.city.image,
              width: double.infinity,
              height: double.infinity,
              iconError: const Icon(Icons.error)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 45,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment(0.0, -1.279),
                      end: Alignment(0.0, 0.618),
                      colors: [Color(0x000d0d0d), Color(0xff000000)],
                      stops: [0.0, 1.0])),
            ),
          ),

          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 6, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        sizedWidth(paddingCityTitle),
                        Texts(
                          title: getText(response.city.title),
                          textColor: Colors.white,
                          fontSize: 14,
                          weight: FontWeight.normal,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.sunny,
                          color: Colors.white,
                        )
                        //         Texts(
                        //   title: weather.icon,
                        //   textColor: Colors.white,
                        //   fontSize: 14,
                        //   weight: FontWeight.bold,
                        // ),
                        // Texts(
                        //   title: weather.summary,
                        //   textColor: Colors.white,
                        //   fontSize: 14,
                        //   weight: FontWeight.normal,
                        // ),
                      ],
                    )
                  ],
                ),
              )),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 36, left: 20, right: 20),
              child: Directionality(
                textDirection: ui.TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImageWidget(
                        height: 80,
                        width: 80,
                        image: response.country.image,
                        iconError: const Icon(Icons.error),
                      ),
                    ),
                    IconFavorite(
                      id: response.city.id,
                      type: 0,
                    ),
                  ],
                ),
              ),
            ),
          )

          // CachedNetworkImageWidget(
          //     image: response.country.image,
          //     width: double.infinity,
          //     height: double.infinity,

          //     iconError: const Icon(Icons.error_outline)),

          // Align(
          //   alignment: Alignment.center,
          //   child: Container(
          //     height: 150,
          //     width: 120,

          //     child: Stack(
          //       children: [

          //         ClipRRect(
          //           borderRadius: BorderRadius.circular(15),
          //           child: CachedNetworkImageWidget( image: response.city.image,
          //               width: double.infinity,
          //               height: double.infinity,
          //               iconError: const Icon(Icons.error_outline)

          //           ),
          //         ),

          //         Container(
          //          decoration: BoxDecoration(
          //            borderRadius: BorderRadius.circular(15)
          //          ),
          //         ),

          //         Align(
          //           alignment: Alignment.bottomCenter,
          //           child: Container(
          //             height: 45,
          //             decoration:  BoxDecoration(

          //                 gradient:LinearGradient(
          //                     begin: Alignment(0.0, -1.279),
          //                     end: Alignment(0.0, 0.618),
          //                     colors: [Color(0x000d0d0d), Color(0xff000000)],
          //                     stops: [0.0, 1.0]
          //                 ),

          //               borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),
          //               bottomRight: Radius.circular(15)),
          //             ),
          //           ),
          //         )
          //         , Align(
          //           alignment: Alignment.bottomLeft,
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Texts(
          //               title: response.city.title,
          //               textColor: Colors.white,
          //               fontSize: 16,
          //               weight: FontWeight.bold,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          // Container(
          //   height: double.infinity,
          //   width: widthScreen(context) / 2.5,
          //   decoration: const BoxDecoration(
          //     color: Color(0xa61a232a),
          //   ),
          //   child: Stack(
          //
          //    children: [
          //     // SvgPicture.asset("assets/icons/weather.svg"),
          //     // sizedHeight(10),
          //      CachedNetworkImageWidget(
          //          image: response.country.image,
          //          width: double.infinity,
          //          height: double.infinity,
          //          iconError: const Icon(Icons.error_outline)),
          //   Container(
          //              decoration: BoxDecoration(
          //                borderRadius: BorderRadius.circular(15),
          //                color: Colors.black.withOpacity(.3)
          //              ),
          //             ),
          //     Align(
          //       alignment: Alignment.center,
          //       child: Texts(
          //         title:  response.city.title,
          //         textColor: Colors.white,
          //         fontSize: 25,
          //         weight: FontWeight.bold,
          //       ),
          //     ),

          //     // sizedHeight(15)
          //   ]),
          // ),
          //
        ],
      ),
    );
  }
}

class PlacesListWidget extends StatefulWidget {
  final List<Place> places;
  final List<City> cities;

  const PlacesListWidget(this.places, this.cities, {super.key});

  @override
  State<PlacesListWidget> createState() => _PlacesListWidgetState();
}

class _PlacesListWidgetState extends State<PlacesListWidget> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ListPlacesGridWidget(places:widget.places),
          ),
        );

        //  ListView.builder(
        //     padding: EdgeInsets.zero,
        //     itemCount:widget.places.length,
        //     shrinkWrap: true,
        //     itemBuilder: (context, index) {
        //       Place place = widget.places[index];
        //       return GestureDetector(
        //         onTap: () {
        //           //  pushPage(context, PlaceDetailsScreen(place.id));
        //           // Navigator.of(context).push(CustomPageRoute(
        //           //                   child: PlaceDetailsScreen(place.id),
        //           //                   direction: AxisDirection.up));

        //           Navigator.push(
        //               context,
        //               PageTransition(
        //                   duration: Duration(milliseconds: 500),
        //                   reverseDuration: Duration(milliseconds: 500),
        //                   alignment: Alignment.center,
        //                   curve: Curves.ease,
        //                   type: PageTransitionType.bottomToTop,
        //                   child: PlaceDetailsListScreen(
        //                     cityId: place.cityId,
        //                     index: place.id,
        //                   )));

        //           // showBottomSheetWidget(context,place.id);

        //           // todo :  show bottom sheet
        //         },
        //         child: Container(
        //           height: 140,
        //           decoration: const BoxDecoration(),
        //           child: Stack(children: [
        //             CachedNetworkImageWidget(
        //                 image: place.image,
        //                 width: double.infinity,
        //                 height: double.infinity,
        //                 iconError: const Icon(Icons.error)),
        //             Align(
        //               alignment: Alignment.bottomCenter,
        //               child: Container(
        //                 height: 45,
        //                 decoration: const BoxDecoration(
        //                     gradient: LinearGradient(
        //                         begin: Alignment(0.0, -1.279),
        //                         end: Alignment(0.0, 0.618),
        //                         colors: [
        //                           Color(0x000d0d0d),
        //                           Color(0xff000000)
        //                         ],
        //                         stops: [
        //                           0.0,
        //                           1.0
        //                         ])),
        //               ),
        //             ),
        //             Align(
        //                 alignment: Alignment.topCenter,
        //                 child: Padding(
        //                   padding: const EdgeInsets.only(
        //                       left: 10, right: 10, top: 4),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.end,
        //                     children: [
        //                       IconFavorite(
        //                         id: place.id,
        //                         type: 1,
        //                       ),
        //                     ],
        //                   ),
        //                 )),
        //             Align(
        //                 alignment: Alignment.bottomCenter,
        //                 child: Padding(
        //                   padding: const EdgeInsets.only(
        //                       bottom: 8, left: 10, right: 10),
        //                   child: Row(
        //                     children: [
        //                       Row(
        //                         mainAxisSize: MainAxisSize.min,
        //                         children: [
        //                           const Icon(
        //                             Icons.location_on,
        //                             color: Colors.white,
        //                           ),
        //                           sizedWidth(paddingCityTitle),
        //                           Texts(
        //                             title: getText(place.title),
        //                             textColor: Colors.white,
        //                             fontSize: 14,
        //                             weight: FontWeight.normal,
        //                           ),
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                 ))
        //           ]),
        //         ),
        //       );
        //     });
      },
    );
  }

  void showBottomSheetWidget(context, placeId) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        builder: (context) {
          return BlocProvider(
            create: (context) =>
                sl<PlaceCubit>()..getPlacesDetails(placeId: placeId),
            child: BlocBuilder<PlaceCubit, PlaceState>(
              builder: (context, state) {
                switch (state.placesStat) {
                  case RequestState.loading:
                    return const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    );

                  case RequestState.loaded:
                    // List<String> images = state.response!.place.image.split("#");
                    return Scaffold(
                      body: SingleChildScrollView(
                          child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: 450,
                            color: backgroundColor,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15))),
                                  height: 450,
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        height: 400,
                                        child: SliderWidget(
                                          controller: _controller,
                                          images: state.response!.photos,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: IndicatorWidget(
                                            state.currentIndex,
                                            state.response!.photos),
                                      ),
                                      // Positioned(
                                      //     left: 25,
                                      //     top: 40,
                                      //     child: GestureDetector(
                                      //       onTap: () {
                                      //         pushPage(
                                      //             context,
                                      //             ShowImageScreen(
                                      //                 placeDetails: state.response!,
                                      //                 images:
                                      //                     state.response!.photos));
                                      //       },
                                      //       child: Container(
                                      //         height: 35,
                                      //         width: 35,
                                      //         padding: const EdgeInsets.all(5),
                                      //         decoration: const BoxDecoration(
                                      //             shape: BoxShape.circle,
                                      //             color: Color(0xffFFFFFF)),
                                      //         child: const Icon(Icons.fullscreen),
                                      //       ),
                                      //     ))

                                      // Positioned(
                                      //   bottom: 60,
                                      //   left: 0,
                                      //   right: 0,
                                      //    child: Container(
                                      //                              margin: const EdgeInsets.symmetric(horizontal: 24),
                                      //                              height: 50,

                                      //                              child: Row(
                                      //                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //                                children: [
                                      //                                  Row(
                                      //     children: [
                                      //       SvgPicture.asset(
                                      //           "assets/icons/location.svg"),
                                      //       sizedWidth(10),
                                      //       Texts(
                                      //           title:
                                      //               "${state.response!.city.title} , ${state.response!.country.name}",
                                      //           textColor: const Color(0xffCED3D8),
                                      //           fontSize: 16,
                                      //           weight: FontWeight.bold),
                                      //     ],
                                      //                                  ),
                                      //                                  Texts(
                                      //       title: state.response!.place.title,
                                      //       textColor: const Color(0xffCED3D8),
                                      //       fontSize: 16,
                                      //       weight: FontWeight.bold),
                                      //                                ],
                                      //                              ),
                                      //                            ),
                                      //  )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          sizedHeight(15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Texts(
                                title: state.response!.place.desc,
                                textColor: Colors.white,
                                fontSize: 18,
                                weight: FontWeight.normal),
                          ),
                          sizedHeight(25),
                          //  list videos
                          //       SizedBox(
                          //         height: 120,
                          //         child: ListView.builder(
                          //           scrollDirection: Axis.horizontal,
                          //           itemCount: state.response!.videos.length,
                          //           padding: const EdgeInsets.symmetric(horizontal: 20),
                          //           itemBuilder: (BuildContext context, int index) {
                          //             return GestureDetector(
                          //               onTap: (){
                          //  pushPage(context, VideoPlayerScreen(ApiConstants.baseUrlVideos+state.response!.videos[index]));
                          //               },
                          //               child: Container(
                          //                 height: 120,
                          //                 width: 120,
                          //                 margin: const EdgeInsets.symmetric(horizontal: 2),
                          //                 decoration: BoxDecoration(
                          //                   borderRadius: BorderRadius.circular(15),
                          //                 ),
                          //                 child: Stack(children: [
                          //                   ClipRRect(
                          //                       borderRadius: BorderRadius.circular(15),
                          //                       child: VTImageView(
                          //                         videoUrl:ApiConstants.baseUrlVideos+state.response!.videos[index],
                          //                         errorBuilder: (context, error, stack) {
                          //                           return Container(
                          //                             width: 200.0,
                          //                             height: 200.0,
                          //                             color: Colors.black.withOpacity(.5),
                          //                             child:  Center(
                          //                               child: Text(""),
                          //                             ),
                          //                           );
                          //                         },
                          //                         assetPlaceHolder: 'Error',
                          //                       )),
                          //                   Align(
                          //                     alignment: Alignment.center,
                          //                     child: Container(
                          //                       height: 40,
                          //                       width: 40,
                          //                       decoration: const BoxDecoration(
                          //                           shape: BoxShape.circle,
                          //                           color: Colors.white),
                          //                       child: const Padding(
                          //                         padding: EdgeInsets.all(8.0),
                          //                         child: Icon(
                          //                           Icons.play_arrow,
                          //                           color: Color.fromARGB(255, 129, 128, 128),
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   )
                          //                 ]),
                          //               ),
                          //             );
                          //           },
                          //         ),
                          //       )
                        ],
                      )),
                    );
                  case RequestState.error:
                    return Scaffold(
                      body: Center(
                        child: Texts(
                            title: state.message,
                            textColor: Colors.white,
                            fontSize: 16,
                            weight: FontWeight.bold),
                      ),
                    );
                  case RequestState.pagination:
                    return const SizedBox();
                }
              },
            ),
          );
        });
  }
}




// list places 