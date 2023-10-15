import 'package:cached_network_image/cached_network_image.dart';
import 'package:exit_travil/core/helpers/helper_functions.dart';
import 'package:exit_travil/data/models/city_model.dart';
import 'package:exit_travil/data/models/country_model.dart';
import 'package:exit_travil/data/models/response_photos.dart';
import 'package:exit_travil/domin/entities/city_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../../core/utlis/api_constatns.dart';
import '../../../../../core/widgets/place_holder_widget.dart';
import '../../../../../data/models/photo_model.dart';
import '../../display_images_screen/display_images_screen.dart';

class ListPhotos extends StatefulWidget {
  final CityResponse photos;
  // ignore: prefer_const_constructors_in_immutables
  ListPhotos(this.photos, {super.key});

  @override
  State<ListPhotos> createState() => _ListPhotosState();
}

class _ListPhotosState extends State<ListPhotos> {
  List<PhotoResponse> photsResponse = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.photos.photos.forEach((element) {
      PhotoResponse photoResponse = PhotoResponse(
          city: widget.photos.city as CityModel,
          country: widget.photos.country as CountryModel,
          photo: element as PhotoModel);
      photsResponse.add(photoResponse);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      padding: EdgeInsets.zero,
      //  if (state.photosStat == RequestState.pagination)

      gridDelegate: SliverQuiltedGridDelegate(crossAxisCount: 3, pattern: [
        const QuiltedGridTile(2, 2),
        const QuiltedGridTile(1, 1),
        const QuiltedGridTile(2, 1),
        const QuiltedGridTile(1, 2),
      ]),
      childrenDelegate: SliverChildBuilderDelegate((ctx, index) {
        // PhotoModel photoModel = photos.photos![index];

        return GestureDetector(
          onTap: () {
            pushPage(context,
                DisplayImagesScreen(images: photsResponse, first: photsResponse.first));
          },
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: CachedNetworkImage(
              key: UniqueKey(),
              cacheManager: CustomCacheManager.instance,
              imageUrl:
                  ApiConstants.imageUrl(widget.photos.photos[index].image),
              placeholder: (context, url) => PlaceHolderWidget(),
              fit: BoxFit.cover,
            ),
          ),
        );
      }, childCount: widget.photos.photos.length),
    );
  }
}
