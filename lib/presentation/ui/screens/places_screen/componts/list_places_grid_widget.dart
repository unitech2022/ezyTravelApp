import 'package:exit_travil/core/helpers/helper_functions.dart';
import 'package:exit_travil/core/styles/sizing.dart';
import 'package:exit_travil/core/widgets/cached_image_widget.dart';
import 'package:exit_travil/core/widgets/texts.dart';
import 'package:exit_travil/presentation/ui/screens/cities_screen/cities_screen.dart';
import 'package:exit_travil/presentation/ui/screens/place_details/place_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../../domin/entities/place.dart';

class ListPlacesGridWidget extends StatelessWidget {
  final List<Place> places;
  const ListPlacesGridWidget({
    super.key,
    required this.places,
  
  });



  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      axisDirection: AxisDirection.down,
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: List.generate(places.length, (index) {
        Place place =places[index];
        return StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: index == 0 ? 1.2 : 1.4,
          child: GestureDetector(
            onTap: () {
              //  pushPage(context, PlaceDetailsScreen(place.id));
              // Navigator.of(context).push(CustomPageRoute(
              //                   child: PlaceDetailsScreen(place.id),
              //                   direction: AxisDirection.up));

              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(milliseconds: 500),
                      reverseDuration: Duration(milliseconds: 500),
                      alignment: Alignment.center,
                      curve: Curves.ease,
                      type: PageTransitionType.bottomToTop,
                      child: PlaceDetailsListScreen(
                        cityId: place.cityId,
                        index: place.id,
                      )));

              // showBottomSheetWidget(context,place.id);

              // todo :  show bottom sheet
            },
            child: Container(
              height: 140,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImageWidget(
                      image: place.image,
                      width: double.infinity,
                      height: double.infinity,
                      iconError: const Icon(Icons.error)),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
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
                            id: place.id,
                            type: 1,
                          ),
                        ],
                      ),
                    )),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(bottom: 8, left: 10, right: 10),
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
                                title: getText(place.title),
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
          ),
        );
      }).toList(),
    );
  }
}

