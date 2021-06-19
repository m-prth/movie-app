import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/app_error.dart';

import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/entities/video_entity.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/domain/usecases/usecase.dart';

class GetVideos extends UseCase<List<VideoEntity>, MovieParams> {
  final MovieRepository repository;

  GetVideos(this.repository);

  Future<Either<AppError, List<VideoEntity>>> call(
      MovieParams movieParams) async {
    return await repository.getVideos(movieParams.id);
  }
}
