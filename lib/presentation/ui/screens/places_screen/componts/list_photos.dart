import 'package:cached_network_image/cached_network_image.dart';
import 'package:exit_travil/core/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../../core/utlis/api_constatns.dart';
import '../../../../../core/widgets/place_holder_widget.dart';
import '../../../../../data/models/photo_model.dart';

class ListPhotos extends StatelessWidget {
  final List<PhotoModel> photos;
  // ignore: prefer_const_constructors_in_immutables
  ListPhotos(this.photos, {super.key});
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
        PhotoModel photoModel = photos[index];

        return Padding(
          padding: const EdgeInsets.all(1),
          child: CachedNetworkImage(
            key: UniqueKey(),
            cacheManager: CustomCacheManager.instance,
            imageUrl: ApiConstants.imageUrl(photoModel.image),
            placeholder:(context, url) => PlaceHolderWidget(),
            fit: BoxFit.cover,
          ),
        );
      }, childCount: photos.length),
    );
  }
}
