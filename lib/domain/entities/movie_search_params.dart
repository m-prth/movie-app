import 'package:equatable/equatable.dart';

class MovieSearchParams extends Equatable {
  final String searchTerm;

  MovieSearchParams({this.searchTerm});

  @override
  List<Object> get props => [searchTerm];
}
