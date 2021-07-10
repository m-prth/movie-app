import 'package:movie_app/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/login_request_params.dart';
import 'package:movie_app/domain/repositories/authentication_repository.dart';
import 'package:movie_app/domain/usecases/usecase.dart';

class LoginUser extends UseCase<bool, LoginRequestParams> {
  final AuthenticationRepository _authenticationRepository;

  LoginUser(this._authenticationRepository);

  @override
  Future<Either<AppError, bool>> call(params) async =>
      _authenticationRepository.loginUser(params.toJson());
}
