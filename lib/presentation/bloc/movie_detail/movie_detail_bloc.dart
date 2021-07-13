import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_detail_entity.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/usecases/get_movie_detail.dart';
import 'package:movie_app/presentation/bloc/cast/cast_bloc.dart';
import 'package:movie_app/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:movie_app/presentation/bloc/loading/loading_bloc.dart';
import 'package:movie_app/presentation/bloc/videos/videos_bloc.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final CastBloc castBloc;
  final VideosBloc videosBloc;
  final FavoriteBloc favoriteBloc;
  final LoadingBloc loadingBloc;

  MovieDetailBloc({
    @required this.loadingBloc,
    @required this.castBloc,
    @required this.getMovieDetail,
    @required this.videosBloc,
    @required this.favoriteBloc,
  }) : super(MovieDetailInitial());

  @override
  Stream<MovieDetailState> mapEventToState(
    MovieDetailEvent event,
  ) async* {
    if (event is MovieDetailLoadEvent) {
      loadingBloc.add(StartLoading());
      final Either<AppError, MovieDetailEntity> eitherResponse =
          await getMovieDetail(
        MovieParams(event.movieId),
      );
      yield eitherResponse.fold(
        (l) => MovieDetailError(),
        (r) => MovieDetailLoaded(r),
      );

      favoriteBloc.add(CheckIfFavoriteMovieEvent(event.movieId));
      castBloc.add(LoadCastEvent(movieId: event.movieId));
      videosBloc.add(LoadVideosEvent(movieId: event.movieId));
      loadingBloc.add(FinishLoading());
    }
  }
}
