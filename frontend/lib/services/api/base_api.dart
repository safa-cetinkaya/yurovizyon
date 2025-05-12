import 'dart:convert';
import 'dart:developer';
// import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:frontend/providers/routes.dart';
import 'package:frontend/providers/storage.dart';
import 'package:frontend/providers/utils.dart';
import 'package:frontend/screens/splash/splash_screen.dart';
import 'package:http/http.dart';

enum RequestType { get, post }

class BaseAPI {
  static String? host;
  static String? baseServer;
  static String? sessionId;

  static const Duration _durationTime = Duration(seconds: 10);

  static void setBaseServer() {
    host = kDebugMode ? Utils.devServer : Utils.prodServer;
    baseServer = "$host/api";
  }

  static Future<dynamic> fetch(
    String url, {
    Map<String, String> params = const {},
    Map<String, String> body = const {},
    RequestType requestType = RequestType.get,
    bool check = true,
  }) async {
    Response res = await _fetch(url,
        params: params, body: body, requestType: requestType, check: check);

    return jsonDecode(res.body);
  }

  static Future<Response> fetchFile(
    String url, {
    Map<String, String> params = const {},
    Map<String, String> body = const {},
    RequestType requestType = RequestType.get,
    bool check = true,
  }) async {
    return _fetch(url,
        params: params, body: body, requestType: requestType, check: check);
  }

  static Future<Response> _fetch(
    String url, {
    Map<String, String> params = const {},
    Map<String, String> body = const {},
    RequestType requestType = RequestType.get,
    bool check = true,
  }) async {
    final Client client = Client();
    final Uri parsedUrl = Uri.parse(baseServer! + url + paramsToString(params));
    final Map<String, String> headers = {};
    if (sessionId != null) {
      headers["session-id"] = sessionId!;
    }

    log(parsedUrl.toString());

    Response response;
    if (requestType == RequestType.get) {
      response =
          await client.get(parsedUrl, headers: headers).timeout(_durationTime);
    } else {
      response = await client
          .post(parsedUrl, headers: headers, body: body)
          .timeout(_durationTime);
    }

    try {
      Map<String, dynamic> body = jsonDecode(response.body);
      log(body.toString());

      if (body['message'] == 'no_session') {
        Storage.user = null;
        await Storage.prefs.remove('session-id');

        Routes.popAll();
        Routes.replace(path: SplashScreen.route);
      }
    } catch (_) {}

    if (check) {
      checkAndThrow(response);
    }

    return response;
  }

  static String paramsToString(Map<String, String> params) {
    if (params.isEmpty) return "";

    String paramString = "";
    for (var param in params.entries) {
      paramString += "&${param.key}=${param.value}";
    }
    paramString = "?${paramString.substring(1)}";
    return paramString;
  }

  static checkAndThrow(Response res) {
    log(res.statusCode.toString());

    if (res.statusCode != 200 && res.statusCode != 201) {
      Map<String, dynamic> body = jsonDecode(res.body);
      throw body['error'] ?? body['message'] ?? "Error Code: ${res.statusCode}";
    }
  }
}
