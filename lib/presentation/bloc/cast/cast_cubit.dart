import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/cast_entity.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/usecases/get_cast_crew.dart';

part 'cast_state.dart';

class CastCubit extends Cubit<CastState> {
  final GetCastCrew getCastCrew;

  CastCubit({@required this.getCastCrew}) : super(CastInitial());

  void loadCast(int movieId) async {
    Either<AppError, List<CastEntity>> eitherResponse =
        await getCastCrew(MovieParams(movieId));

    emit(eitherResponse.fold(
      (l) => CastError(),
      (r) => CastLoaded(casts: r),
    ));
  }
}
