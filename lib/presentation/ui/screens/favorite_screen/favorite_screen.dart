import 'package:easy_localization/easy_localization.dart';
import 'package:exit_travil/core/utlis/strings.dart';
import 'package:exit_travil/presentation/controller/favorite_cubit/cubit/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/sizing.dart';
import '../../../../core/utlis/enums.dart';
import '../../../../core/widgets/cached_image_widget.dart';
import '../../../../core/widgets/texts.dart';
import '../../../../domin/entities/city.dart';
import '../cities_screen/cities_screen.dart';
import '../places_screen/places_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

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
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          switch (state.favState) {
            case RequestState.loaded:
              return state.favorites.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.favorites.length,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        City city = state.favorites[index];
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
                                      padding: const EdgeInsets.only(left: 10,right: 10,top: 4),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          IconFavorite(city: city),
                                        ],
                                      ),
                                    )),
                                Align(
                                    alignment: Alignment.bottomCenter,

                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8,right: 8,bottom: 4),
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
                                                title:getText(city.title) ,
                                                textColor: Colors.white,
                                                fontSize: 14,
                                                weight: FontWeight.normal,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ))]),
                          ),
                        );
                      })
                  : Center(
                      child: Texts(
                      title: Strings.notFav.tr(),
                      textColor: textColor,
                      fontSize: 16,
                      weight: FontWeight.normal,
                    ));

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
