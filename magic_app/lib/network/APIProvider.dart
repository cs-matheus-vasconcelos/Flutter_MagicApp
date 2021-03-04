import 'NetworkError.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class APIProvider {

  String _baseURL;
  http.Client _client;

  APIProvider([this._baseURL ,this._client]) {
    _client = _client ?? http.Client();
    _baseURL = _baseURL ?? "https://api.magicthegathering.io";
  }

  Future<dynamic> get(String path) async {
    var responseJSON;
    try {
      final response = await _client.get(_baseURL+path);
      responseJSON = _responseToJSON(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJSON;
  }

  dynamic _responseToJSON(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body.toString());
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw AuthenticationRequiredException(response.body.toString);
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw ServerErrorException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

}