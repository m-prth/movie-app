import 'package:equatable/equatable.dart';

class CastEntity extends Equatable {
  final String creditId;
  final String name;
  final String posterPath;
  final String character;

  CastEntity({this.creditId, this.name, this.posterPath, this.character});

  @override
  List<Object> get props => [creditId];
}
