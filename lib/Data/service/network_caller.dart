import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Ui/controler/auth_controler.dart';
import 'package:untitled/Ui/login_screen.dart';
import 'package:untitled/app.dart';

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? body;
  final String? errormessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.body,
    this.errormessage,
  });
}

class NetworkCaller {
  static const String _defaultErrorMessage = "Something went wrong";
  static const String _unAuthorizedMessage = "Un-authorized token";

  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      final Map<String, String> headers = {
        'token': AuthController.accessToken ?? ''
      };

      _logRequest(url, null, headers);

      http.Response response = await http.get(uri, headers: headers);

      _logResponse(url, response);

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedJson,
        );
      } else if (response.statusCode == 401) {
        _unAuthorized(); // Token invalid হলে logout করে
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errormessage: _unAuthorizedMessage,
        );
      } else {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errormessage: decodedJson["data"] ?? _defaultErrorMessage,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errormessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, String>? body,
    bool isFormLogin = false,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      final Map<String, String> headers = {
        'content-type': 'application/json',
        'token': AuthController.accessToken ?? ''
      };

      _logRequest(url, body, headers);

      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      _logResponse(url, response);

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedJson,
        );
      } else if (response.statusCode == 401) {
        if (!isFormLogin) {
          _unAuthorized();
          return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errormessage: _unAuthorizedMessage,
          );
        } else {
          final decodedJson = jsonDecode(response.body);
          return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errormessage: decodedJson["data"] ?? _defaultErrorMessage,
          );
        }
      } else {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errormessage: decodedJson["data"] ?? _defaultErrorMessage,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errormessage: e.toString(),
      );
    }
  }


  static void _logRequest(String url, Map<String, String>? body, Map<String, String> headers) {
    debugPrint("===========Request==========\n"
        "URL: $url\n"
        "HEADER: $headers\n"
        "BODY: $body\n"
        "=======================");
  }

  static void _logResponse(String url, http.Response response) {
    debugPrint("===========Response==========\n"
        "URL: $url\n"
        "STATUSCODE: ${response.statusCode}\n"
        "BODY: ${response.body}\n"
        "=======================");
  }

  static void _unAuthorized() async {
    await AuthController.clearData();
    Navigator.of(TaskManagerApp.navigator.currentContext!).pushAndRemoveUntil(
    SignInScreen.name as Route<Object?>,
          (route) => false,
    );
  }
}
