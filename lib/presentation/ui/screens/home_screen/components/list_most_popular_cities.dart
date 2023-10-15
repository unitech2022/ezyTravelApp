import 'package:cached_network_image/cached_network_image.dart';
import 'package:exit_travil/core/helpers/helper_functions.dart';

import 'package:exit_travil/core/styles/sizing.dart';
import 'package:exit_travil/core/utlis/api_constatns.dart';
import 'package:exit_travil/core/widgets/cached_image_widget.dart';
import 'package:exit_travil/core/widgets/texts.dart';
import 'package:exit_travil/data/models/home_model.dart';
import 'package:exit_travil/presentation/ui/screens/cities_screen/cities_screen.dart';
import 'package:flutter/material.dart';

class ListMostPopularCities extends StatelessWidget {
 final List<ResponseCityHome> mostPopularCities;
  const ListMostPopularCities({
    super.key,required this.mostPopularCities
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 180,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount:mostPopularCities.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                    showBottomSheetWidgetPlaces(context,  mostPopularCities[index].city.id);
              },
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                height: double.infinity,
                width: widthScreen(context) / 1.43,
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        imageUrl: ApiConstants.baseUrlImages +
                          mostPopularCities[index].city.image,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Icon(
                          Icons.photo,
                          size: 50,
                        ),
                      ),
                    ),
                    
                    // *** image Country
                      Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 5,left: 5,right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImageWidget(
                        height: 60,
                        width: 60,
                        image: mostPopularCities[index].country.image,
                        iconError: const Icon(Icons.error),
                      ),
                      
                      
                    ),SizedBox()
              
                  
                  ],
                ),
              ),
                      ),
            
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
                          padding: const EdgeInsets.only(
                              bottom: 8, left: 10, right: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                color: Colors.white,size: 20,
                              ),
                            
                              Texts(
                                title: getText(
                                    mostPopularCities[index].city.title),
                                textColor: Colors.white,
                                fontSize: 14,
                                weight: FontWeight.normal,
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
