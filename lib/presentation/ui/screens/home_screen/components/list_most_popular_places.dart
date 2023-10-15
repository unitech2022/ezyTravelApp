import 'package:cached_network_image/cached_network_image.dart';
import 'package:exit_travil/core/helpers/helper_functions.dart';
import 'package:exit_travil/core/styles/sizing.dart';
import 'package:exit_travil/core/utlis/api_constatns.dart';
import 'package:exit_travil/core/widgets/texts.dart';
import 'package:exit_travil/data/models/home_model.dart';
import 'package:exit_travil/presentation/ui/screens/place_details/place_details.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ListMostPopularPlaces extends StatelessWidget {
  final List<ResponsePlaceHome> mostPopularPlaces;
  const ListMostPopularPlaces({super.key, required this.mostPopularPlaces});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 240,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: mostPopularPlaces.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                  Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(milliseconds: 500),
                      reverseDuration: Duration(milliseconds: 500),
                      alignment: Alignment.center,
                      curve: Curves.ease,
                      type: PageTransitionType.bottomToTop,
                      child: PlaceDetailsListScreen(
                        cityId: mostPopularPlaces[index].place.cityId,
                        index:  mostPopularPlaces[index].place.id,
                      )));
              },
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                height: double.infinity,
                width: widthScreen(context)/ 2.8,
                margin: EdgeInsets.symmetric(horizontal: 5),
                
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: ApiConstants.baseUrlImages +
                            mostPopularPlaces[index].place.image,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Icon(
                          Icons.photo,
                          size: 50,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 55,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                          ),
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
                          padding: const EdgeInsets.only(
                              bottom: 8, left: 5, right: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Texts(
                                    title:
                                        getText(mostPopularPlaces[index].place.title),
                                    textColor: Colors.white,
                                    fontSize: 12,
                                    weight: FontWeight.normal,
                                  ),
                                ],
                              ),
                              sizedHeight(5),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.white,size: 20,
                                  ),
                                  sizedWidth(0),
                                  Texts(
                                    title: getText(mostPopularPlaces[index]
                                        .country
                                        .name),
                                    textColor: Colors.white,
                                    fontSize: 12,
                                    weight: FontWeight.normal,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            );
          }),
        ));
  }
}
