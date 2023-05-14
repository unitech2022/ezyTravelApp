import 'package:cached_network_image/cached_network_image.dart';
import 'package:exit_travil/core/helpers/helper_functions.dart';
import 'package:exit_travil/core/styles/colors.dart';
import 'package:exit_travil/core/utlis/api_constatns.dart';
import 'package:exit_travil/core/utlis/data.dart';
import 'package:exit_travil/domin/entities/continent.dart';
import 'package:exit_travil/presentation/controller/home_bloc/home_cubit.dart';
import 'package:exit_travil/presentation/ui/screens/cities_screen/cities_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utlis/enums.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FocusNode? focusNode;
  final _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStateGetHome>(
      builder: (context, state) {
        switch (state.homeDataState) {
          case RequestState.loading:
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          case RequestState.error:
            return Container(
              child: Text(
                state.message,
                style: GoogleFonts.cairo(
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 16)),
              ),
            );
          case RequestState.loaded:
          case RequestState.pagination:
            return Scaffold(
              backgroundColor: const Color(0xff1A1A1A),
              resizeToAvoidBottomInset: false,
              body: Container(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, bottom: 50),
                child: Column(
                  children: [
                  
                    sizedHeight(10),
                    Expanded(
                        child: Row(
                      children: [
                        ExpandedContinent(
                            continent: state.homeModel!.continents[0]),
                        sizedWidth(10),
                        ExpandedContinent(
                            continent: state.homeModel!.continents[1]),
                      ],
                    )),
                    sizedHeight(10),
                    Expanded(
                        child: Row(
                      children: [
                        ExpandedContinent(
                            continent: state.homeModel!.continents[2]),
                        sizedWidth(10),
                        ExpandedContinent(
                            continent: state.homeModel!.continents[3]),
                      ],
                    ))
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}

class ExpandedContinent extends StatelessWidget {
  final Continent continent;

  const ExpandedContinent({super.key, required this.continent});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        // Navigator.of(context).push(CustomPageRoute(
        //     child: CitiesScreen(continent: continent),
        //     direction: AxisDirection.right));

        // pushPage(
        //   context,
        //   CitiesScreen(continent: continent),
        // );

        Navigator.push(
            context,
            PageTransition(
                duration: Duration(milliseconds: 100),
                reverseDuration: Duration(milliseconds: 100),
                alignment: Alignment.center,
                curve: Curves.ease,
                type: PageTransitionType.fade,
                child: CitiesScreen(continent: continent)));
      },
      child: Hero(
        tag: "${continent.id}",
        child: Container(
          width: double.infinity,
          height: double.infinity,

          child: Column(
            children: [
              Expanded(
                  child: Container(
                    color: Colors.black,
                    child: CachedNetworkImage(
                imageUrl: ApiConstants.baseUrlImages + continent.image,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.contain,
                errorWidget: (context, url, error) => const Icon(
                    Icons.photo,
                    size: 50,
                ),
              ),
                  )),
              sizedHeight(10),
              Text(
                currentLang=="ar"?continent.name.split("*")[0]:continent.name.split("*")[1],
                style: GoogleFonts.cairo(
                    textStyle: const TextStyle(fontSize: 14, color: textColor,fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
