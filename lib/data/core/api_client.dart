import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_app/data/core/api_constants.dart';
import 'package:movie_app/data/core/unauthorized_exception.dart';

class ApiClient {
  final Client _client;

  ApiClient(this._client);

  dynamic get(String path, {Map<dynamic, dynamic> params}) async {
    final response = await _client.get(
      getPath(path, params),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic post(String path, {Map<dynamic, dynamic> params}) async {
    final response = await _client.post(
      getPath(path, null),
      body: jsonEncode(params),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  String getPath(String path, Map<dynamic, dynamic> params) {
    var paramsString = "";
    if (params?.isNotEmpty ?? false) {
      params.forEach((key, value) {
        paramsString += '&$key=$value';
      });
    }
    return '${ApiConstants.BASE_URL}$path?api_key=${ApiConstants.API_KEY}$paramsString';
  }
}
