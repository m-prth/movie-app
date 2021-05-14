import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class MovieEntity extends Equatable {
  final String posterPath;
  final int id;
  final String backdropPath;
  final String title;
  final num voteAverage;
  final String releaseDate;
  final String overview;

  const MovieEntity({
    @required this.title,
    @required this.voteAverage,
    @required this.releaseDate,
    @required this.overview,
    @required this.posterPath,
    @required this.id,
    @required this.backdropPath,
  }) : assert(id != null, "Movie id must not be null");

  @override
  List<Object> get props => [id, title];

  @override
  bool get stringify => true;
}
