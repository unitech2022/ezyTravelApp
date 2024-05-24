import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:exit_travil/core/helpers/helper_functions.dart';
import 'package:exit_travil/core/styles/colors.dart';
import 'package:exit_travil/core/utlis/enums.dart';
import 'package:exit_travil/core/widgets/cached_image_widget.dart';
import 'package:exit_travil/domin/entities/continent.dart';
import 'package:exit_travil/domin/entities/country.dart';
import 'package:exit_travil/presentation/ui/screens/places_screen/places_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/styles/sizing.dart';
import '../../../../core/utlis/data.dart';
import '../../../../core/utlis/strings.dart';
import '../../../../core/widgets/texts.dart';
import '../../../../domin/entities/city.dart';
import '../../../controller/country_bloc/country_cubit.dart';
import '../../../controller/favorite_cubit/cubit/favorite_cubit.dart';
import 'componts/row_details_country.dart';

class CitiesScreen extends StatelessWidget {
  final Continent continent;

  const CitiesScreen({super.key, required this.continent});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<CountryCubit>()..getCountriesByContinentId(continent.id),
      child: BlocBuilder<CountryCubit, CountryState>(
        builder: (context, state) {
          switch (state.countryState) {
            case RequestState.loading:
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            case RequestState.loaded:
              List<List<Country>> lists = state.countries!.slices(4).toList();

              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  automaticallyImplyLeading: true,
                  elevation: 0,
                  title: Texts(
                    title: getText(continent.name),
                    textColor: Colors.white,
                    fontSize: 16,
                    weight: FontWeight.normal,
                  ),
                ),
                body: state.countries!.isEmpty
                    ? Center(
                        child: Texts(
                          title: Strings.notCountries.tr(),
                          textColor: Colors.white,
                          fontSize: 18,
                          weight: FontWeight.normal,
                        ),
                      )
                    : Hero(
                        tag: "${continent.id}",
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // sizedHeight(20),
                              // state.countries!.length > 4
                              //     ?
                              CarouselSlider.builder(
                                itemCount: lists.length,
                                itemBuilder: (BuildContext context,
                                        int itemIndex, int pageViewIndex) =>
                                    Container(
                                  child: ListCountries(
                                      lists[itemIndex], state.currentIndex),
                                ),
                                options: CarouselOptions(
                                  onPageChanged: (index, reason) {
                                    CountryCubit.get(context)
                                        .changeIndexCountryPage(index);
                                  },
                                  autoPlay: false,
                                  enableInfiniteScroll: false,
                                  viewportFraction: .8,
                                  aspectRatio: 1.3,
                                  // initialPage: 2,
                                ),
                              )
                              //     :
                              // ListCountries(
                              //         state.countries!, state.currentIndex)
                              ,

                              state.countries!.length > 4
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                          lists.length,
                                          (index) => Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 3),
                                                width: 30,
                                                height: 3,
                                                decoration: BoxDecoration(
                                                    color:
                                                        state.currentIndexPage ==
                                                                index
                                                            ? Colors.white
                                                                .withOpacity(.8)
                                                            : Colors.white12,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                              )),
                                    )
                                  : Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 3),
                                      width: 30,
                                      height: 3,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),

                              sizedHeight(10),
                              const DetailsCountry()
                            ],
                          ),
                        ),
                      ),
              );
            case RequestState.error:
              // TODO: Handle this case.
              return Scaffold(
                body: Text(
                  state.message,
                  style: GoogleFonts.cairo(
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 16)),
                ),
              );
            case RequestState.pagination:
              // TODO: Handle this case.
              return SizedBox();
          }
        },
      ),
    );
  }
}

class ListCountries extends StatefulWidget {
  final List<Country> countries;
  final int currentIndex;
  const ListCountries(this.countries, this.currentIndex, {super.key});
  @override
  State<ListCountries> createState() => _ListCountriesState();
}

class _ListCountriesState extends State<ListCountries> {
  ScrollController scrollController = ScrollController();
  int countIndicator = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 280,
        child: GridView.builder(
            controller: scrollController,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: widget.countries.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              Country country = widget.countries[index];
              return GestureDetector(
                onTap: () {
                  CountryCubit.get(context).changeIndexCountry(country.id);
                  CountryCubit.get(context)
                      .getCitiesByCountryId(countryId: country.id);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImageWidget(
                          height: 90,
                          width: 90,
                          image: country.image,
                          iconError: const Icon(Icons.error),
                        ),
                      ),
                      sizedHeight(13),
                      Texts(
                        title: currentLang == "ar"
                            ? country.name.split("*")[0]
                            : country.name.split("*")[1],
                        textColor: textColor,
                        fontSize: 14,
                        weight: FontWeight.normal,
                      ),
                      sizedHeight(10),
                      Container(
                          height: 3,
                          width: 90,
                          color: widget.currentIndex == country.id
                              ? Colors.white
                              : Colors.transparent)
                    ],
                  ),
                ),
              );
            }));
  }
}

class DetailsCountry extends StatelessWidget {
  const DetailsCountry({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryCubit, CountryState>(
      builder: (context, state) {
        switch (state.citiesState) {
          case RequestState.loaded:
            return Column(
              children: [
                RowDetailsCountry(state.detailsCountry!.country),
                sizedHeight(10),
                state.detailsCountry!.cities.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 100.0),
                        child: Texts(
                          title: Strings.notCities.tr(),
                          textColor: Colors.white,
                          fontSize: 18,
                          weight: FontWeight.normal,
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: state.detailsCountry!.cities.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          City city = state.detailsCountry!.cities[index];
                          return GestureDetector(
                            onTap: () {
                              // pushPage(context, PlacesScreen(cityId: city.id));
                              // Navigator.of(context).push(CustomPageRoute(
                              //     child: PlacesScreen(cityId: city.id),
                              //     direction: AxisDirection.down));

                              // Navigator.push(
                              //     context,
                              //     PageTransition(
                              //         duration: Duration(milliseconds: 300),
                              //         reverseDuration:
                              //             Duration(milliseconds: 300),
                              //         // alignment: Alignment.center,
                              //         curve: Curves.ease,
                              //         type: PageTransitionType.leftToRight,
                              //         child: PlacesScreen(cityId: city.id)));

                              showBottomSheetWidgetPlaces(context, city.id);
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
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8, bottom: 4),
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
                        })
              ],
            );

          case RequestState.loading:
            return const Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: CircularProgressIndicator(
                color: Colors.white,
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
                weight: FontWeight.normal,
              )),
            );
          case RequestState.pagination:
            // TODO: Handle this case.
            return const SizedBox();
        }
      },
    );
  }
}

void showBottomSheetWidgetPlaces(context, cityId) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) {
        return PlacesScreen(cityId: cityId);
      });
}

class IconFavorite extends StatelessWidget {
  final int id, type;
  const IconFavorite({Key? key, required this.id, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        return IconButton(
          icon: Icon(
            type == 0
                ? FavoriteCubit.get(context).ids.contains(id.toString())
                    ? Icons.favorite
                    : Icons.favorite_border_outlined
                : FavoriteCubit.get(context).idsPlace.contains(id.toString())
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            if (type == 0) {
              FavoriteCubit.get(context).addFavorite(id.toString());
            } else {
              FavoriteCubit.get(context).addFavoritePlace(id.toString());
            }
          },
        );
      },
    );
  }
}


/* 

   // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: List.generate(
        //       5,
        //       (index) => Container(
        //             margin: EdgeInsets.symmetric(horizontal: 3),
        //             width: 30,
        //             height: 3,
        //             decoration: BoxDecoration(
        //                 color: widget.currentIndex == index
        //                     ? Colors.white.withOpacity(.8)
        //                     : Colors.white12,
        //                 borderRadius: BorderRadius.circular(20)),
        //           )),
        // )

        //======

        /*
Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImageWidget(
                              height: 90,
                              width: 90,
                              image: country.image,
                              iconError: const Icon(Icons.error),
                            ),
                          ),
                          sizedHeight(13),
                          Texts(
                            title: country.name,
                            textColor: textColor,
                            fontSize: 14,
                            weight: FontWeight.normal,
                          ),
                          sizedHeight(10),
                          Container(
                              height: 3,
                              width: 90,
                              color: widget.currentIndex == index
                                  ? Colors.white
                                  : Colors.transparent)
                        ],
                      ),
                    ),
                 
        */

        /* 

Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Stack(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: CachedNetworkImageWidget(
                                  height: 90,
                                  width: 90,
                                  image: country.image,
                                  iconError: const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          // sizedHeight(13),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 30,
                              width: double.infinity,
                             
                              margin: EdgeInsets.all(1),
                             alignment: Alignment.center,
                              child: Texts(
                                title: country.name,
                                textColor: textColor,
                                fontSize: 14,
                                
                                weight: FontWeight.normal,
                                
                                
                              ),
                            ),
                          ),
                          sizedHeight(10),
                          AnimatedContainer(
                              height: double.infinity,
                              width: double.infinity,
                              curve: Curves.easeInOut,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: widget.currentIndex == index
                                  ? Colors.white.withOpacity(.15)
                                  : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  
                              ), duration: Duration(milliseconds: 300),
                              )
                        ],
                      ),
                    ),
                  
    */

        ScrollIndicator(
          scrollController: scrollController,
          width: 100,
          height: 3,
          indicatorWidth: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white12),
          indicatorDecoration: BoxDecoration(
              color: Colors.white.withOpacity(.8),
              borderRadius: BorderRadius.circular(10)),
        ),
*/