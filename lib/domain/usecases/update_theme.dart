import 'package:dartz/dartz.dart';

import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/repositories/app_repository.dart';
import 'usecase.dart';

class UpdateTheme extends UseCase<void, String> {
  final AppRepository appRepository;

  UpdateTheme(this.appRepository);

  @override
  Future<Either<AppError, void>> call(String themeName) async {
    return await appRepository.updateTheme(themeName);
  }
}
