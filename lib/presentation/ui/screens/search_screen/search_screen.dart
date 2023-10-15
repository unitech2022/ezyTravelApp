
import 'package:exit_travil/core/widgets/texts.dart';
import 'package:exit_travil/presentation/controller/search_cubit/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utlis/enums.dart';
import '../../../../core/utlis/strings.dart';
import '../../../../core/widgets/cached_image_widget.dart';
import '../../../../domin/entities/city.dart';

import '../places_screen/places_screen.dart';

class SearchCityScreen extends StatefulWidget {
  const SearchCityScreen({super.key});

  @override
  State<SearchCityScreen> createState() => _SearchCityScreenState();
}

class _SearchCityScreenState extends State<SearchCityScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchCubit>(),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                title: Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.search,
                    style: GoogleFonts.cairo(
                        textStyle: const TextStyle(color: Colors.white)),
                    onSubmitted: (value) {},
                    onChanged: (value) async {
                      if (_controller.text.isNotEmpty) {
                        SearchCubit.get(context)
                            .searchCities(textSearch: _controller.text.trim());
                      }
                    },
                    decoration: InputDecoration(
                      hintText: Strings.search,
                      hintStyle: GoogleFonts.cairo(
                          textStyle:
                              TextStyle(color: Colors.white.withOpacity(.5))),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      suffixIcon: InkWell(
                          onTap: () {
                            _controller.clear();
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          )),
                      border: InputBorder.none,
                    ),
                  ),
                )),
            body: _bodyWidget(state),
          );
        },
      ),
    );
  }

  Widget _bodyWidget(SearchState state) {
    switch (state.citiesStat) {
      case RequestState.loaded:
        return state.response.isEmpty
            ? const Center(
          child: Texts(
            title: Strings.notCitiesResult,
            textColor: Colors.white,
            fontSize: 18,
            weight: FontWeight.normal,
          ),
        )
            : ListView.builder(

            itemCount: state.response.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              City city = state.response[index].city;
              return GestureDetector(
                onTap: () {
                  pushPage(context, PlacesScreen(cityId: city.id));
                },
                child: Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.grey,width: .8
                          )
                      )
                  ),
                  child: Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: CachedNetworkImageWidget(
                          image: city.image,
                          width: 80,
                          height: 80,
                          iconError: const Icon(Icons.error)),
                    ),
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: Container(
                    //     height: 45,
                    //     decoration: const BoxDecoration(
                    //         gradient: LinearGradient(
                    //             begin: Alignment(0.0, -1.279),
                    //             end: Alignment(0.0, 0.618),
                    //             colors: [
                    //           Color(0x000d0d0d),
                    //           Color(0xff000000)
                    //         ],
                    //             stops: [
                    //           0.0,
                    //           1.0
                    //         ])),
                    //   ),
                    // ),
                    sizedWidth(30),
                    // Positioned(
                    //     right: 10, top: 4, child: IconFavorite(city: city)),
                    Expanded(
                      child: Texts(
                        title: city.title,
                        textColor: Colors.white,
                        fontSize: 14,
                        weight: FontWeight.normal,
                      ),
                    )
                  ]),
                ),
              );
            });

      case RequestState.error:
        return Text(
          state.message,
          style: GoogleFonts.cairo(
              textStyle: const TextStyle(color: Colors.white, fontSize: 16)),
        );

      case RequestState.pagination:
        return const SizedBox();
      case RequestState.loading:
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
    }
  }


}

class BodySearchWidget extends StatelessWidget {
  final SearchState state;
  BodySearchWidget(this.state);

  @override
  Widget build(BuildContext context) {
    return _bodyWidget(state);
  }

  Widget _bodyWidget(SearchState state) {
    switch (state.citiesStat) {
      case RequestState.loaded:
        return state.response.isEmpty
            ? const Center(
          child: Texts(
            title: Strings.notCitiesResult,
            textColor: Colors.white,
            fontSize: 18,
            weight: FontWeight.normal,
          ),
        )
            : ListView.builder(

            itemCount: state.response.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              City city = state.response[index].city;
              return GestureDetector(
                onTap: () {
                  SearchCubit.get(context).searchCities(textSearch: city.title);
                },
                child: Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.grey,width: .8
                          )
                      )
                  ),
                  child: Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: CachedNetworkImageWidget(
                          image: city.image,
                          width: 80,
                          height: 80,
                          iconError: const Icon(Icons.error)),
                    ),
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: Container(
                    //     height: 45,
                    //     decoration: const BoxDecoration(
                    //         gradient: LinearGradient(
                    //             begin: Alignment(0.0, -1.279),
                    //             end: Alignment(0.0, 0.618),
                    //             colors: [
                    //           Color(0x000d0d0d),
                    //           Color(0xff000000)
                    //         ],
                    //             stops: [
                    //           0.0,
                    //           1.0
                    //         ])),
                    //   ),
                    // ),
                    sizedWidth(30),
                    // Positioned(
                    //     right: 10, top: 4, child: IconFavorite(city: city)),
                    Expanded(
                      child: Texts(
                        title: city.title,
                        textColor: Colors.white,
                        fontSize: 14,
                        weight: FontWeight.normal,
                      ),
                    )
                  ]),
                ),
              );
            });

      case RequestState.error:
        return Text(
          state.message,
          style: GoogleFonts.cairo(
              textStyle: const TextStyle(color: Colors.white, fontSize: 16)),
        );

      case RequestState.pagination:
        return const SizedBox();
      case RequestState.loading:
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
    }
  }
}


class SearchCityWidget extends SearchDelegate{

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [

    IconButton(onPressed: (){

      if(query.isEmpty){
        close(context, null);
      }else{
        query='';
      }
    }, icon: Icon(Icons.close
    ))];

  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
   return IconButton(onPressed: ()=>close(context, null), icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return BlocProvider(
        create: (context) => sl<SearchCubit>(),
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            return Scaffold(

              body: BodySearchWidget(state),
            );
          },
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
if(query.isNotEmpty){
  SearchCubit.get(context).searchCities(textSearch: query);
}
    return BlocBuilder<SearchCubit, SearchState>(
    builder: (context, state) {

    return Scaffold(

    body: BodySearchWidget(state),
    );
    },
    );
  }
}
