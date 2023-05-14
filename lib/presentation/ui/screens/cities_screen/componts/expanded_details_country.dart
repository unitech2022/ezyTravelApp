import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/styles/colors.dart';
import '../../../../../core/widgets/texts.dart';

class ExpandedDetailsCountry extends StatelessWidget {
  final String image;
  final String title, value;
  ExpandedDetailsCountry(
      {super.key,
      required this.image,
      required this.title,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0x0dffffff),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Column(children: [
          SvgPicture.asset(
            image,
            height: 40,
            width: 40,
          ),
          Texts(title: title, textColor: Colors.white, fontSize: 18,weight: FontWeight.normal,),
          Texts(title: value, textColor: textColor, fontSize: 13,weight: FontWeight.normal,),
        ]),
      ),
    );
  }
}
