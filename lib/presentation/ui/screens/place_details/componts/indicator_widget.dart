import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndicatorWidget extends StatelessWidget {
  final int index;
  final List<String> images;
  const IndicatorWidget(this.index, this.images, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images
                .asMap()
                .entries
                .map((e) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 5,
                      width: 25,
                      decoration: BoxDecoration(
                          color: index == e.key
                              ? Colors.white
                              : const Color(0xff6C767D),
                          borderRadius: BorderRadius.circular(15)),
                    ))
                .toList(),
          ),
        ));
  }
}
