import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/utlis/strings.dart';
import '../../../../../domin/entities/country.dart';
import 'expanded_details_country.dart';

class RowDetailsCountry extends StatelessWidget {
  final Country country;

  RowDetailsCountry(this.country);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          ExpandedDetailsCountry(
            image: "assets/icons/capital.svg",
            title: Strings.capital.tr(),
            value:getText(country.capital),
          ),
          sizedWidth(12),
          ExpandedDetailsCountry(
            image: "assets/icons/lang.svg",
            title: Strings.lang.tr(),
            value:getText(country.language) ,
          ),
          sizedWidth(12),
        


            ExpandedDetailsCountry(
            image: "assets/icons/currency.svg",
            title: Strings.currency.tr(),
            value:getText(country.currency) ,
          ),
        ],
      ),
    );
  }
}

