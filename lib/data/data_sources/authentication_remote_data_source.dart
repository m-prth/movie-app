import 'package:movie_app/data/models/request_token_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<RequestTokenModel> getRequestToken();
  Future<RequestTokenModel> validateWithLogIn(Map<String, dynamic> requestBody);
  Future<String> createSession(Map<String, dynamic> requestBody);
}
