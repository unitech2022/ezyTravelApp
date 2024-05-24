import 'package:carousel_slider/carousel_slider.dart';
import 'package:exit_travil/core/widgets/back_buttons_widget.dart';


import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';


import '../../../../core/helpers/helper_functions.dart';

import '../../../../core/utlis/api_constatns.dart';

import '../../../../core/widgets/texts.dart';
import '../../../../data/models/response_photos.dart';
import '../places_screen/places_screen.dart';

class DisplayImagesScreen extends StatefulWidget {
  final List<PhotoResponse> images;
  final PhotoResponse first;
  DisplayImagesScreen({required this.images, required this.first});

  @override
  State<DisplayImagesScreen> createState() => _DisplayImagesScreenState();
}

class _DisplayImagesScreenState extends State<DisplayImagesScreen> {
  @override
  void initState() {
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CarouselSlider.builder(
              itemBuilder: (BuildContext context, int index, int realIndex) {
                PhotoResponse photoResponse = widget.images[index];
                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                        child: PhotoView(
                          imageProvider: NetworkImage(
                              ApiConstants.imageUrl(photoResponse.photo.image)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if( photoResponse.city!=null){
                            pushPage(context,
                              PlacesScreen(cityId: photoResponse.city!.id));
                          }
                          
                        },
                        child: Container(
                          height: 40,
                          // color: backgroundColor,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              
                              
                              Texts(
                                  title:
                                    photoResponse.city!=null?  getText(photoResponse.city!.title) +" , "
                                      + getText(photoResponse.country!.name):"",
                                  textColor: const Color(0xffCED3D8),
                                  fontSize: 16,
                                  weight: FontWeight.bold),
                                  sizedWidth(10),
                                  SvgPicture.asset("assets/icons/location.svg"),
                                  
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: widget.images.length,
              options: CarouselOptions(
                  autoPlayCurve: Curves.fastOutSlowIn,
                  // height: 450.0,
                  scrollDirection: Axis.vertical,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {}),
            ),
        Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top :30.0,left: 18,right: 18),
                          child: BackButtonWidget(),
                        ),
                      ),
       
          ],
        ),
      ),
    );

    // Column(
    //   children: [
    //     Expanded(
    //       child: PhotoViewGallery.builder(
    //           itemCount: widget.images.length + 1,
    //           scrollDirection: Axis.vertical,
    //           onPageChanged: (index) {
    //             currentPhoto = widget.images[index];
    //             setState(() {

    //             });
    //           },
    //           builder: (ctx, index) {
    //             if (index == 0)
    //               return PhotoViewGalleryPageOptions(
    //                 imageProvider: NetworkImage(
    //                     ApiConstants.imageUrl(widget.first.photo.image)),
    //                 initialScale: PhotoViewComputedScale.contained * 0.8,
    //               );

    //             PhotoResponse photoModel = widget.images[index - 1];
    //             return PhotoViewGalleryPageOptions(
    //               imageProvider: NetworkImage(
    //                   ApiConstants.imageUrl(photoModel.photo.image)),
    //               initialScale: PhotoViewComputedScale.contained * 0.8,
    //             );
    //           }),
    //     ),

    //   ],
    // );
  }
}
