import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/cast_entity.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/usecases/get_cast_crew.dart';

part 'cast_event.dart';
part 'cast_state.dart';

class CastBloc extends Bloc<CastEvent, CastState> {
  final GetCastCrew getCastCrew;

  CastBloc({@required this.getCastCrew}) : super(CastInitial());

  @override
  Stream<CastState> mapEventToState(
    CastEvent event,
  ) async* {
    if (event is LoadCastEvent) {
      Either<AppError, List<CastEntity>> eitherResponse =
          await getCastCrew(MovieParams(event.movieId));
      yield eitherResponse.fold(
          (l) => CastError(), (r) => CastLoaded(casts: r));
    }
  }
}
