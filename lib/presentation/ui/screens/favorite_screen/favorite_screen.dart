import 'package:easy_localization/easy_localization.dart';
import 'package:exit_travil/core/utlis/strings.dart';
import 'package:exit_travil/presentation/controller/favorite_cubit/cubit/favorite_cubit.dart';
import 'package:exit_travil/presentation/ui/screens/places_screen/componts/places_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/sizing.dart';
import '../../../../core/utlis/enums.dart';
import '../../../../core/widgets/cached_image_widget.dart';
import '../../../../core/widgets/texts.dart';
import '../../../../domin/entities/city.dart';
import '../cities_screen/cities_screen.dart';
import '../places_screen/places_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Widget> screens = [];
  PageController controllerPage = PageController(initialPage: 0);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerPage.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Texts(
          title: Strings.favorite.tr(),
          textColor: Colors.white,
          fontSize: 16,
          weight: FontWeight.normal,
        ),
      ),
      body: BlocConsumer<FavoriteCubit, FavoriteState>(
        listener: (context, state) {
          print(state);
        },
        builder: (context, state) {
          if (state.favorites != null) {
            screens = [
              state.favorites!.cities.isNotEmpty
                  ? ListCitiesFavWidget(state)
                  : Center(
                      child: Texts(
                      title: Strings.notFav.tr(),
                      textColor: textColor,
                      fontSize: 16,
                      weight: FontWeight.normal,
                    )),
              state.favorites!.places.isNotEmpty
                  ? PlacesListFavWidget(state.favorites!.places,state.favorites!.citiesOfPlaces)
                  : Center(
                      child: Texts(
                      title: Strings.notFav.tr(),
                      textColor: textColor,
                      fontSize: 16,
                      weight: FontWeight.normal,
                    )),
            ];
          }

          switch (state.favState) {
            case RequestState.loaded:
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        ContainerTabFav(
                          height: 26,
                          icon: "assets/icons/city.svg",
                          textColor: state.currentIndex == 0
                              ? Colors.white
                              : Colors.white30,
                          backgroundColor: state.currentIndex == 0
                              ? Colors.white
                              : Colors.transparent,
                          title: Strings.cities.tr(),
                          onTap: () {
                            controllerPage.jumpToPage(0);
                            FavoriteCubit.get(context).changIndexTab(0);
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ContainerTabFav(
                          height: 26,
                          icon: "assets/icons/map.svg",
                          textColor: state.currentIndex == 1
                              ? Colors.white
                              : Colors.white30,
                          backgroundColor: state.currentIndex == 1
                              ? Colors.white
                              : Colors.transparent,
                          title: Strings.places.tr(),
                          onTap: () {
                            controllerPage.jumpToPage(1);
                            FavoriteCubit.get(context).changIndexTab(1);
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
                      FavoriteCubit.get(context).changIndexTab(value);
                    },
                    children: screens,
                  ))
                ],
              );

            case RequestState.loading:
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            case RequestState.error:
              return Text(
                state.message,
                style: GoogleFonts.cairo(
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 16)),
              );
            case RequestState.pagination:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

class ListCitiesFavWidget extends StatelessWidget {
  final FavoriteState state;
  ListCitiesFavWidget(this.state);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: state.favorites!.cities.length,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          City city = state.favorites!.cities[index];
          return GestureDetector(
            onTap: () {
              pushPage(context, PlacesScreen(cityId: city.id));
            },
            child: Container(
              height: 140,
              decoration: const BoxDecoration(),
              child: Stack(children: [
                CachedNetworkImageWidget(
                    image: city.image,
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
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconFavorite(
                            id: city.id,
                            type: 0,
                          ),
                        ],
                      ),
                    )),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 4),
                      child: Row(
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
                                title: getText(city.title),
                                textColor: Colors.white,
                                fontSize: 14,
                                weight: FontWeight.normal,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
              ]),
            ),
          );
        });
  }
}

class ContainerTabFav extends StatelessWidget {
  final String icon;
  final String title;
  final void Function() onTap;
  final double height;
  final Color textColor, backgroundColor;
  ContainerTabFav(
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
          height: 40,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(25),

           border: Border(
             bottom: BorderSide(color: backgroundColor,width: 2),

           )
          ),
          child: Center(
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
      ),
    );
  }
}

