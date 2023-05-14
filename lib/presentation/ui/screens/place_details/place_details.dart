import 'package:carousel_slider/carousel_slider.dart';
import 'package:exit_travil/core/helpers/helper_functions.dart';
import 'package:exit_travil/core/styles/colors.dart';
import 'package:exit_travil/core/utlis/api_constatns.dart';

import 'package:exit_travil/core/widgets/texts.dart';
import 'package:exit_travil/data/models/place_details_model.dart';
import 'package:exit_travil/presentation/controller/place_cubit/place_cubit.dart';
import 'package:exit_travil/presentation/ui/screens/show_image_screen/show_image_screen.dart';
import 'package:exit_travil/presentation/ui/screens/video_player_screen/video_player_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:video_thumbnail_imageview/video_thumbnail_imageview.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utlis/enums.dart';

import '../../../../core/widgets/back_buttons_widget.dart';
import '../../../../domin/entities/place.dart';
import '../../../../domin/entities/place_details.dart';
import 'componts/indicator_widget.dart';
import 'componts/slider_widget.dart';

class PlaceDetailsScreen extends StatefulWidget {
  final int placeId;
  PlaceDetailsScreen(this.placeId, {super.key});

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceCubit, PlaceState>(
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
                                    state.currentIndex, state.response!.photos),
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

                              Positioned(
                                bottom: 60,
                                left: 0,
                                right: 0,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/location.svg"),
                                          sizedWidth(10),
                                          Texts(
                                              title:
                                                  "${state.response!.city.title} , ${state.response!.country.name}",
                                              textColor:
                                                  const Color(0xffCED3D8),
                                              fontSize: 16,
                                              weight: FontWeight.bold),
                                        ],
                                      ),
                                      Texts(
                                          title: state.response!.place.title,
                                          textColor: const Color(0xffCED3D8),
                                          fontSize: 16,
                                          weight: FontWeight.bold),
                                    ],
                                  ),
                                ),
                              )
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
    );
  }
}

// place details list

class PlaceDetailsListScreen extends StatefulWidget {
  final int cityId, index;
  PlaceDetailsListScreen({required this.cityId, required this.index});

  @override
  State<PlaceDetailsListScreen> createState() => _PlaceDetailsListScreenState();
}

class _PlaceDetailsListScreenState extends State<PlaceDetailsListScreen> {
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PlaceCubit.get(context)
        .getListPlacesData(cityId: widget.cityId, index: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceCubit, PlaceState>(
      builder: (context, state) {
        return Scaffold(
            body: state.placesStat == RequestState.loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Stack(
                    children: [
                      CarouselSlider.builder(
                          itemCount: state.listPlaceDetails!.length,
                          itemBuilder: (ctx, index, page) {
                            PlaceDetails placeDetails =
                                state.listPlaceDetails![index];
                            return Container(
                              height: heightScreen(context),
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
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15))),
                                          height: 450,
                                          child: Stack(
                                            children: [
                                              SizedBox(
                                                height: 400,
                                                child: SliderWidget(
                                                  controller: _controller,
                                                  images: placeDetails.photos,
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: IndicatorWidget(
                                                    state.currentIndex,
                                                    placeDetails.photos),
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
                                              //   child: Container(
                                              //     margin: const EdgeInsets.symmetric(
                                              //         horizontal: 24),
                                              //     height: 50,
                                              //     child: Row(
                                              //       mainAxisAlignment:
                                              //           MainAxisAlignment
                                              //               .spaceBetween,
                                              //       children: [
                                              //         Row(
                                              //           children: [
                                              //             SvgPicture.asset(
                                              //                 "assets/icons/location.svg"),
                                              //             sizedWidth(10),
                                              //             Texts(
                                              //                 title:
                                              //                     "${placeDetails.city.title} , ${placeDetails.country.name}",
                                              //                 textColor: const Color(
                                              //                     0xffCED3D8),
                                              //                 fontSize: 16,
                                              //                 weight:
                                              //                     FontWeight.bold),
                                              //           ],
                                              //         ),
                                              //         Texts(
                                              //             title: placeDetails.place.title,
                                              //             textColor:
                                              //                 const Color(0xffCED3D8),
                                              //             fontSize: 16,
                                              //             weight: FontWeight.bold),
                                              //       ],
                                              //     ),
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // sizedHeight(10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Column(
                                      children: [
                                        Texts(
                                            title: getText(
                                                placeDetails.place.title),
                                            textColor: const Color(0xffCED3D8),
                                            fontSize: 18,
                                            weight: FontWeight.bold),
                                        sizedHeight(10),
                                        Texts(
                                            title: getText(
                                                placeDetails.place.desc),
                                            textColor: Colors.white54,
                                            fontSize: 16,
                                            weight: FontWeight.normal),
                                      ],
                                    ),
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
                              ),
                            );
                          },
                          options: CarouselOptions(
                              height: heightScreen(context),
                              enableInfiniteScroll: false,
                              viewportFraction: 1,
                              scrollDirection: Axis.vertical)),
                  
                     Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top :30.0,left: 18,right: 18),
                          child: BackButtonWidget(),
                        ),
                      ),
                   
                    ],
                  ));
      },
    );
  }
}

