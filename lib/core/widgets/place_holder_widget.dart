import 'package:flutter/cupertino.dart';

class PlaceHolderWidget extends StatelessWidget {
  const PlaceHolderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 90,
        width: 90,
        child: Image.asset("assets/images/newlogo.png")),
    );
  }
}
