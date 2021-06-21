part of 'search_movie_bloc.dart';

abstract class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

class SearchMovieInitial extends SearchMovieState {}

class SearchMovieLoaded extends SearchMovieState {
  final List<MovieEntity> movies;
  SearchMovieLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class SearchMovieLoading extends SearchMovieState {}

class SearchMovieError extends SearchMovieState {
  final AppErrorType appErrorType;

  SearchMovieError(this.appErrorType);
  @override
  List<Object> get props => [appErrorType];
}
