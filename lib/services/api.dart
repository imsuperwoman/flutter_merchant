import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'api_url.dart';

var logger = Logger();

Map<String, String> headers = {"Accept": "application/json"};

class Api {
  var language;
  int timeoutInSecond = 30;

  Future<dynamic> delete(String url,
      {required Map<String, String> headers, body, encoding}) async {
    return http
        .delete(Uri.http(ApiUrl.baseUrl, url), headers: headers)
        .timeout(Duration(seconds: timeoutInSecond))
        .then((http.Response response) {
      logger.i("url: DEL $url");
      logger.i("header: ${headers.toString()}");
      logger.i("request: $body");
      return _responseChecking(response);
    }, onError: _onError);
  }

  Future<dynamic> get(String url, Map<String, String> headers) async {
    return http
        .get(Uri.http(ApiUrl.baseUrl, url), headers: headers)
        .timeout(Duration(seconds: timeoutInSecond))
        .then((http.Response response) {
      logger.i("url: GET $url");
      logger.i("header: ${headers.toString()}");
      return _responseChecking(response);
    }, onError: _onError);
  }

  Future<dynamic> post(String url, body) async {
    return http
        .post(Uri.https(ApiUrl.baseUrl, url, body))
        .timeout(Duration(seconds: timeoutInSecond))
        .then((http.Response response) {
      logger.i("url: POST $url");
      logger.i("request: $body");
      return _responseChecking(response);
    }, onError: _onError);
  }

  Future<Map<String, dynamic>?> postMultipartRequest(request) async {
    // Now we can make this call
    logger.i("url: POST $request");
    logger.i("request: $request.fields");
    http.Response response =
        await http.Response.fromStream(await request.send());
    return _responseChecking(response);
  }

  Future<dynamic> put(String url,
      {required Map<String, String> headers, body, encoding}) async {
    return http
        .put(Uri.http(ApiUrl.baseUrl, url),
            body: body, headers: headers, encoding: encoding)
        .timeout(Duration(seconds: timeoutInSecond))
        .then((http.Response response) {
      logger.i("url: PUT $url");
      logger.i("header: ${headers.toString()}");
      logger.i("request: $body");
      return _responseChecking(response);
    }, onError: _onError);
  }

  _onError(e) {
    if (e is SocketException) {
      throw "error_no_connection";
    }
    if (e is TimeoutException) {
      throw "error_request_timeout";
    }
  }

  _responseChecking(http.Response response) {
    logger.e("response: ${response.body}");
    logger.e("statusCode: ${response.statusCode}");

    switch (response.statusCode) {
      case 200:
        return Map<String, dynamic>.from(json.decode(response.body));

      case 401:
        Map<String, dynamic> message = {
          "status": "401",
          "message":
              json.decode(response.body)["message"] ?? "error_unknown_error"
        };
        return message;

      case 404:
        Map<String, dynamic> message = {
          "status": "404",
          "message": json.decode(response.body)["message"] ??
              "error_404_server_not_found"
        };
        return message;

      case 500:
        Map<String, dynamic> message = {
          "status": "500",
          "message": json.decode(response.body)["message"] ??
              "error_500_internal_server_error"
        };
        return message;
      case 503:
        Map<String, dynamic> message = {
          "status": "500",
          "message": json.decode(response.body)["message"] ??
              "error_503_service_unavailable"
        };
        return message;

      case 502:
        Map<String, dynamic> message = {
          "status": "502",
          "message":
              json.decode(response.body)["message"] ?? "error_502_bad_gateway"
        };
        return message;

      case 504:
        Map<String, dynamic> message = {
          "status": "504",
          "message": json.decode(response.body)["message"] ??
              "error_504_gateway_timeout_server"
        };
        return message;

      default:
        //400 Bad Request
        return Map<String, dynamic>.from(json.decode(response.body));
    }
  }
}

class ApiHeaders {
  static Map<String, String> mapHeaders(String token) {
    return {"Content-Type": "application/json"};
  }
}
