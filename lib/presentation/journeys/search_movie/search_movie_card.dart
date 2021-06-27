import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/route_constants.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/data/core/api_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/presentation/journeys/movie_detail/movie_detail_arguement.dart';
import 'package:movie_app/presentation/themes/theme_text.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';


class SearchMovieCard extends StatelessWidget {
  final MovieEntity movie;

  const SearchMovieCard({
    Key key,
    @required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          RouteList.movieDetail,
          arguments: MovieDetailArguements(movie.id),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_16.w,
          vertical: Sizes.dimen_2.h,
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(Sizes.dimen_8.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Sizes.dimen_4.w),
                child: CachedNetworkImage(
                  imageUrl: '${ApiConstants.BASE_IMAGE_URL}${movie.posterPath}',
                  width: Sizes.dimen_80.w,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    movie.overview,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.greyCaption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
