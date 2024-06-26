import 'package:easy_localization/easy_localization.dart';
import 'package:exit_travil/core/helpers/helper_functions.dart';
import 'package:exit_travil/core/styles/colors.dart';
import 'package:exit_travil/core/widgets/texts.dart';
import 'package:exit_travil/presentation/controller/app_bloc/app_cubit.dart';
import 'package:exit_travil/presentation/ui/screens/discover_screen/discover_screen.dart';
import 'package:exit_travil/presentation/ui/screens/favorite_screen/favorite_screen.dart';
import 'package:exit_travil/presentation/ui/screens/home_screen/home_screen.dart';
import 'package:exit_travil/presentation/ui/screens/places_screen/places_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utlis/enums.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/cached_image_widget.dart';
import '../../../domin/entities/city.dart';
import '../../controller/search_cubit/cubit/search_cubit.dart';
import 'dart:ui' as ui;

class NavigationScreen extends StatefulWidget {
  NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  List<Widget> screens = [
    DiscoverScreen(),
    const HomeScreen(),
    const FavoriteScreen(),
  ];

  FocusNode? focusNode;
  final _controller = TextEditingController();
  PageController controllerPage = PageController(initialPage: 1);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode = FocusNode();
  }

  int currentIndex = 1;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    controllerPage.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Padding(
                padding: EdgeInsets.only(
                    top:  0),
                child: IndexedStack(
                  children: screens,
                  index:  AppCubit.get(context).currentIndex,
                  // onPageChanged: (value) {
                  //   AppCubit.get(context).changeIndexNavigation(value);
                  // },
                )
                //  IndexedStack(
                //   index: AppCubit.get(context).currentIndex,
                //   children: screens,
                // ),
                ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 35,
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                color: Colors.transparent,
                child: Directionality(

                  textDirection: ui.TextDirection.rtl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    
                    
                    children: [
                      GestureDetector(
                        onTap: () {
                          // controllerPage.jumpTo(0);
                          AppCubit.get(context).changeIndexNavigation(0);
                        },
                        child: AnimatedContainer(
                          alignment: Alignment.center,
                
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppCubit.get(context).currentIndex == 0
                                  ? backgroundColor
                                  : Colors.transparent),
                          duration: const Duration(milliseconds: 400),
                          // Provide an optional curve to make the animation feel smoother.
                          curve: Curves.fastOutSlowIn,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.public_sharp,
                                color: Colors.white,
                              ),
                              sizedWidth(5),
                              AppCubit.get(context).currentIndex == 0
                                  ? Texts(
                                      title: Strings.discover.tr(),
                                      textColor:
                                          AppCubit.get(context).currentIndex == 0
                                              ? Colors.white
                                              : Colors.transparent,
                                      fontSize: 14,
                                      weight: FontWeight.normal,
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // controllerPage.jumpToPage(1);
                          AppCubit.get(context).changeIndexNavigation(1);
                        },
                        child: AnimatedContainer(
                          alignment: Alignment.center,
                
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppCubit.get(context).currentIndex == 1
                                  ? backgroundColor
                                  : Colors.transparent),
                          duration: const Duration(milliseconds: 400),
                          // Provide an optional curve to make the animation feel smoother.
                          curve: Curves.fastOutSlowIn,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home,
                                color: Colors.white,
                              ),
                              sizedWidth(5),
                              AppCubit.get(context).currentIndex == 1
                                  ? Texts(
                                      title: Strings.home.tr(),
                                      textColor: Colors.white,
                                      fontSize: 14,
                                      weight: FontWeight.normal,
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // controllerPage.jumpToPage(2);
                          AppCubit.get(context).changeIndexNavigation(2);
                        },
                        child: AnimatedContainer(
                          alignment: Alignment.center,
                
                          padding: EdgeInsets.only(right: 10, left: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppCubit.get(context).currentIndex == 2
                                  ? backgroundColor
                                  : Colors.transparent),
                          duration: const Duration(milliseconds: 400),
                          // Provide an optional curve to make the animation feel smoother.
                          curve: Curves.fastOutSlowIn,
                          child: Row(
                            children: [
                              AppCubit.get(context).currentIndex == 2
                                  ? Texts(
                                      title: Strings.favorite.tr(),
                                      textColor: Colors.white,
                                      fontSize: 14,
                                      weight: FontWeight.normal,
                                    )
                                  : const SizedBox(),
                              sizedWidth(5),
                              const Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),



          ],
        ),
        // bottomNavigationBar: BottomNavyBar(
        //
        //   backgroundColor: Colors.transparent,
        //
        //   showElevation: false,
        //   selectedIndex: AppCubit.get(context).currentIndex,
        //   items: [
        //     BottomNavyBarItem(
        //
        //         icon: const Icon(Icons.public_sharp),
        //
        //         title: const Texts(
        //             title: Strings.discover,
        //             textColor: Colors.white,
        //             fontSize: 14,weight: FontWeight.normal,),
        //         activeColor: Colors.white),
        //     BottomNavyBarItem(
        //       icon: const Icon(Icons.home),
        //       title: const Texts(
        //           title: Strings.home,
        //           textColor: Colors.white,
        //           fontSize: 14,weight: FontWeight.normal,),
        //       activeColor: Colors.white,
        //     ),
        //     BottomNavyBarItem(
        //         icon: const Icon(Icons.favorite),
        //         title: const Texts(
        //             title: Strings.favorite,
        //             textColor: Colors.white,
        //             fontSize: 14,weight: FontWeight.normal,),
        //         activeColor: Colors.white),
        //   ],
        //   onItemSelected: (int value) {
        //     AppCubit.get(context).changeIndexNavigation(value);
        //   },
        // )
      );
    });
  }

  Widget _bodyWidget(SearchState state) {
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
                                title:getText(searchResponse.city.title) ,
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
  }
}
