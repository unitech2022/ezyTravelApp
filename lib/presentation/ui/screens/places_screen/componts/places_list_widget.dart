import 'package:carousel_slider/carousel_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:exit_travil/data/models/city_model.dart';
import 'package:exit_travil/presentation/controller/favorite_cubit/cubit/favorite_cubit.dart';
import 'package:exit_travil/presentation/ui/screens/places_screen/componts/list_places_grid_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:page_transition/page_transition.dart';

import '../../../../../core/helpers/helper_functions.dart';

import '../../../../../core/services/services_locator.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/styles/sizing.dart';
import '../../../../../core/utlis/enums.dart';
import '../../../../../core/widgets/cached_image_widget.dart';
import '../../../../../core/widgets/texts.dart';
import '../../../../../domin/entities/city.dart';
import '../../../../../domin/entities/place.dart';
import '../../../../controller/place_cubit/place_cubit.dart';
import '../../cities_screen/cities_screen.dart';
import '../../place_details/componts/indicator_widget.dart';
import '../../place_details/componts/slider_widget.dart';
import '../../place_details/place_details.dart';

class PlacesListFavWidget extends StatefulWidget {
  final List<Place> places;
  final List<City> cities;

  const PlacesListFavWidget(this.places, this.cities, {super.key});

  @override
  State<PlacesListFavWidget> createState() => _PlacesListFavWidgetState();
}

class _PlacesListFavWidgetState extends State<PlacesListFavWidget> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 40,
              child: ListView.builder(
                  itemCount: widget.cities.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    City city = widget.cities[index];
                    return ContainerTabCityFav(
                      title: getText(city.title),
                      onTap: () {
                        FavoriteCubit.get(context).changIndexTabCity(city.id);
                        FavoriteCubit.get(context).fillterFav(widget.places.where((element) => element.cityId==city.id).toList());
                      },
                      textColor: Colors.black,
                      backgroundColor: state.currentIndexCitySelected == city.id
                          ? Colors.white
                          : Colors.white.withOpacity(.5),
                    );
                  }),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListPlacesGridWidget(places: state.placesFillter)
              
              // ListView.builder(
              //     padding: EdgeInsets.zero,
              //     itemCount:state.placesFillter.length,
              //     shrinkWrap: true,
              //     itemBuilder: (context, index) {
              //       Place place = state.placesFillter[index];
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
              //                       Color(0x000d0d0d),
              //                       Color(0xff000000)
              //                     ],
              //                         stops: [
              //                       0.0,
              //                       1.0
              //                     ])),
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
              //     }),
            
            
            
            ),
          ],
        );
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

class ContainerTabCityFav extends StatelessWidget {
  final String title;
  final void Function() onTap;

  final Color textColor, backgroundColor;

  ContainerTabCityFav({
    required this.title,
    required this.onTap,
    required this.textColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        margin: EdgeInsets.symmetric(horizontal: 3),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: backgroundColor,
        ),
        child: Text(
          title,
          style: GoogleFonts.cairo(
              color: textColor,
              fontSize: 15,
              height: 1.2,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
