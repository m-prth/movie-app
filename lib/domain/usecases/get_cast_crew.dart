import 'package:movie_app/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/cast_entity.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/domain/usecases/usecase.dart';

class GetCastCrew extends UseCase<List<CastEntity>, MovieParams> {
  final MovieRepository repository;
  GetCastCrew(this.repository);

  @override
  Future<Either<AppError, List<CastEntity>>> call(
      MovieParams movieParams) async {
    return await repository.getCastCrew(movieParams.id);
  }
}
