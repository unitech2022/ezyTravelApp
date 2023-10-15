import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:exit_travil/core/helpers/helper_functions.dart';
import 'package:exit_travil/core/styles/colors.dart';
import 'package:exit_travil/core/widgets/texts.dart';
import 'package:exit_travil/data/models/response_photos.dart';
import 'package:exit_travil/presentation/controller/photo_bloc/photo_cubit.dart';
import 'package:exit_travil/presentation/controller/photo_bloc/photo_state.dart';
import 'package:exit_travil/presentation/ui/screens/display_images_screen/display_images_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utlis/api_constatns.dart';
import '../../../../core/utlis/enums.dart';
import '../../../../core/utlis/strings.dart';
import '../../../../core/widgets/place_holder_widget.dart';


class DiscoverScreen extends StatefulWidget {

  DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final ScrollController _scrollController = ScrollController();

  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<PhotoCubit, PhotoState>(
      builder: (context, state) {
        _scrollController.addListener(() {
          if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent) {
            if (currentPage <= PhotoCubit.get(context).totalPages) {
              currentPage++;
              PhotoCubit.get(context).getPhotos(page: currentPage, placId: 0);
            }
          }
        });

        switch (state.photosStat) {
          case RequestState.loading:
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          case RequestState.error:
            return Center(
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
                body: Stack(
              children: [
                Container(
                  height: 80,
                  width: double.infinity,
                  color: backgroundColor,
                  alignment: Alignment.bottomCenter,
                  child:  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Texts(
                      title: Strings.discoverAppBar.tr(),
                      textColor: Colors.white,
                      fontSize: 16,
                      weight: FontWeight.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: state.photosStat == RequestState.pagination
                          ? 60
                          : 0,
                      top: 80),
                  child: GridView.custom(
                    padding: EdgeInsets.zero,
                    //  if (state.photosStat == RequestState.pagination)
                    controller: _scrollController,
                    gridDelegate: SliverQuiltedGridDelegate(
                        crossAxisCount: 3,
                        pattern: [
                          const QuiltedGridTile(2, 2),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(2, 1),
                          const QuiltedGridTile(1, 2),
                        ]),
                    childrenDelegate:
                        SliverChildBuilderDelegate((ctx, index) {
                      PhotoResponse photoModel =
                          PhotoCubit.get(context).items[index] as PhotoResponse;
                      return GestureDetector(
                        onTap: () {
                          List<PhotoResponse> images = PhotoCubit.get(context)
                              .items as List<PhotoResponse>;
                          PhotoResponse photoModel = images[index]; 
                          
     
                          pushPage(
                              context, DisplayImagesScreen(images: images,first:photoModel));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(1),
                          
                          child: CachedNetworkImage(
                            placeholder: (context, url)=>PlaceHolderWidget(),
                            cacheManager: CustomCacheManager.instance,
                            key: UniqueKey(),
                            imageUrl: ApiConstants.imageUrl(photoModel.photo.image),
                            fit: BoxFit.cover,
                            
                          ),
                        ),
                      );
                    }, childCount: PhotoCubit.get(context).items.length),
                  ),
                ),
                if (state.photosStat == RequestState.pagination)
                  const Positioned(
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                      ))
              ],
            ));
        }
      },
    );
  }
}

