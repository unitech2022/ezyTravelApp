import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class Texts extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color textColor;
  final FontWeight weight;

  const Texts(
      {super.key,
      required this.title,
      required this.textColor,
      required this.fontSize
      ,required this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: GoogleFonts.cairo(
          textStyle: TextStyle(fontSize: fontSize, color: textColor,fontWeight: weight,height: 1.2,)),
    );
  }
}
