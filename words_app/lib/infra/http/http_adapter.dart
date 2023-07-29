import 'package:words_app/core/http/http.dart';

import 'package:http/http.dart';
import 'dart:convert';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<dynamic> request(
      {required String url,
      required String method,
      Map? body,
      Map? headers}) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'content-type': 'application/json',
        'accept': 'application/json',
        'X-RapidAPI-Key': '78deb76a33msh66652d47a203c8bp1129b3jsn156cb0132338',
        'X-RapidAPI-Host': 'wordsapiv1.p.rapidapi.com'
      });
    final jsonBody = body != null ? jsonEncode(body) : null;
    var response = Response('', 500);
    Future<Response>? futureResponse;
    try {
      if (method == 'post') {
        futureResponse = client.post(Uri.parse(url),
            headers: defaultHeaders, body: jsonBody);
      } else if (method == 'get') {
        futureResponse = client.get(Uri.parse(url), headers: defaultHeaders);
      } else if (method == 'put') {
        futureResponse =
            client.put(Uri.parse(url), headers: defaultHeaders, body: jsonBody);
      }
      if (futureResponse != null) {
        response = await futureResponse.timeout(const Duration(seconds: 10));
      }
    } catch (error) {
      throw HttpError.serverError;
    }
    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body.isEmpty
            ? null
            : jsonDecode(utf8.decode(response.bodyBytes));
      case 201:
        return response.body.isEmpty
            ? null
            : jsonDecode(utf8.decode(response.bodyBytes));
      case 204:
        return null;
      case 400:
        throw HttpError.badRequest;
      case 401:
        throw HttpError.unauthorized;
      case 403:
        throw HttpError.forbidden;
      case 404:
        throw HttpError.notFound;
      case 422:
        throw HttpError.invalidData;
      default:
        throw HttpError.serverError;
    }
  }
}
