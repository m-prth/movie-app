import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/di/get_it_di.dart';
import 'package:movie_app/presentation/bloc/cast/cast_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie_app/presentation/bloc/videos/videos_bloc.dart';
import 'package:movie_app/presentation/journeys/movie_detail/big_poster.dart';
import 'package:movie_app/presentation/journeys/movie_detail/cast_widget.dart';
import 'package:movie_app/presentation/journeys/movie_detail/movie_detail_arguement.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/presentation/journeys/movie_detail/videos_widget.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieDetailArguements movieDetailArguements;

  const MovieDetailScreen({Key key, @required this.movieDetailArguements})
      : assert(movieDetailArguements != null, "arguements must not be null"),
        super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  MovieDetailBloc _movieDetailBloc;
  CastBloc _castBloc;
  VideosBloc _videosBloc;

  @override
  void initState() {
    super.initState();
    _movieDetailBloc = getItInstance<MovieDetailBloc>();
    _castBloc = _movieDetailBloc.castBloc;
    _videosBloc = _movieDetailBloc.videosBloc;
    _movieDetailBloc
        .add(MovieDetailLoadEvent(widget.movieDetailArguements.movieId));
  }

  @override
  void dispose() {
    _movieDetailBloc?.close();
    _castBloc?.close();
    _videosBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _movieDetailBloc),
          BlocProvider.value(value: _castBloc),
          BlocProvider.value(value: _videosBloc),
        ],
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoaded) {
              final movieDetail = state.movieDetailEntity;
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BigPoster(
                      movie: movieDetail,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.dimen_16.w,
                          vertical: Sizes.dimen_8.h),
                      child: Text(
                        movieDetail.overview,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
                      child: Text(
                        TranslationConstants.cast.t(context),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    CastWidget(),
                    VideosWidget(videosBloc: _videosBloc),
                  ],
                ),
              );
            } else if (state is MovieDetailError) {
              return Container();
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
