import 'package:exit_travil/core/styles/colors.dart';
import 'package:exit_travil/core/utlis/api_constatns.dart';

import 'package:exit_travil/domin/entities/place_details.dart';
import 'package:exit_travil/presentation/ui/screens/places_screen/places_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/widgets/texts.dart';

class ShowImageScreen extends StatelessWidget {
  final PlaceDetails placeDetails;
  final List<String> images;
  const ShowImageScreen(
      {required this.placeDetails, required this.images, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PhotoViewGallery.builder(
            itemCount: images.length,
            onPageChanged: (index) {
              
            },
            builder: (ctx, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider:
                    NetworkImage(ApiConstants.imageUrl(images[index])),
                initialScale: PhotoViewComputedScale.contained * 0.8,
              );
            }),
      
        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {
              pushPage(context, PlacesScreen(cityId: placeDetails.city.id));
            },
            child: Container(
              height: 40,
              color: backgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/location.svg"),
                  sizedWidth(10),
                  Texts(
                      title:
                          "${placeDetails.city.title} , ${placeDetails.country.name}",
                      textColor: const Color(0xffCED3D8),
                      fontSize: 16,
                      weight: FontWeight.bold),
                ],
              ),
            ),
          ),
        )
      
      ]),
    );
  }
}
