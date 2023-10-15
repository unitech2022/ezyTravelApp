import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/cached_image_widget.dart';
import '../../../../controller/place_cubit/place_cubit.dart';

class SliderWidget extends StatelessWidget {
  final List<String> images;


  final CarouselController controller;

  const SliderWidget(
      {super.key,
      required this.images,
      required this.controller,
      });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: controller,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        String image = images[index];
        return ClipRRect(
          // borderRadius: const BorderRadius.only(
          //     bottomLeft: Radius.circular(15),
          //     bottomRight: Radius.circular(15)),
          child: CachedNetworkImageWidget(
              image: image,
              width: double.infinity,
              height: double.infinity,
              
              iconError: const Icon(Icons.error)),
        );
      },
      itemCount: images.length,
      options: CarouselOptions(
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll:false,
          height: 450.0,
          viewportFraction: 1.0,
          onPageChanged: (index, reason) {
            PlaceCubit.get(context).changIndexTab(index);
          }),
    );
  
  
  }
}
