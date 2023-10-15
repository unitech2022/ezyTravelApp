import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';

import '../utlis/api_constatns.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final Widget iconError;

  const CachedNetworkImageWidget(
      {super.key,
      required this.image,
      required this.width,
      required this.height,
      required this.iconError});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: ApiConstants.imageUrl(image),
      height: height,
      width: width,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => const Icon(
        Icons.photo,
        size: 50,
      ),
    );
  }
}
