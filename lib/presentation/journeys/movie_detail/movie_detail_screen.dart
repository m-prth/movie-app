import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/di/get_it_di.dart';
import 'package:movie_app/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie_app/presentation/journeys/movie_detail/big_poster.dart';
import 'package:movie_app/presentation/journeys/movie_detail/movie_detail_arguement.dart';
import 'package:movie_app/common/extensions/size_extension.dart';

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

  @override
  void initState() {
    super.initState();
    _movieDetailBloc = getItInstance<MovieDetailBloc>();
    _movieDetailBloc
        .add(MovieDetailLoadEvent(widget.movieDetailArguements.movieId));
  }

  @override
  void dispose() {
    _movieDetailBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<MovieDetailBloc>.value(
        value: _movieDetailBloc,
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoaded) {
              final movieDetail = state.movieDetailEntity;
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BigPoster(
                    movie: movieDetail,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.dimen_16.w,
                    ),
                    child: Text(
                      movieDetail.overview,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  )
                ],
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
