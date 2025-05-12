import 'package:frontend/models/user.dart';
import 'package:frontend/providers/storage.dart';
import 'package:frontend/services/api/base_api.dart';

class AuthAPI {
  static const String _loginURL = "/auth/login";
  static const String _logoutURL = "/auth/logout";
  static const String _registerURL = "/auth/register";
  static const String _checksessionURL = "/auth/check_session";
  static const String _changePasswordURL = "/auth/change_password";

  static Future<User?> checkSession(String sessionId) async {
    BaseAPI.setBaseServer();
    BaseAPI.sessionId = sessionId;

    Map<String, dynamic> res = await BaseAPI.fetch(_checksessionURL);
    return User.fromJson(res['user']);
  }

  static Future<User?> register(String username, String password) async {
    BaseAPI.setBaseServer();

    Map<String, String> body = {'username': username, 'password': password};

    Map<String, dynamic> res = await BaseAPI.fetch(_registerURL,
        body: body, requestType: RequestType.post);

    BaseAPI.sessionId = res['session_pk'];
    return User.fromJson(res['user']);
  }

  static Future<User?> login(String username, String password) async {
    Map<String, String> body = {
      "username": username,
      "password": password,
    };
    Map<String, dynamic> res = await BaseAPI.fetch(_loginURL,
        body: body, requestType: RequestType.post);

    BaseAPI.sessionId = res['session_pk'];
    return User.fromJson(res['user']);
  }

  static Future<void> logout() async {
    await BaseAPI.fetch(_logoutURL, requestType: RequestType.post);

    await Storage.prefs.remove("session-id");
    Storage.user = null;
  }

  static Future<void> changePassword(
      String oldPassword, String newPassword) async {
    Map<String, String> body = {
      "old_password": oldPassword,
      "new_password": newPassword,
    };
    await BaseAPI.fetch(_changePasswordURL,
        body: body, requestType: RequestType.post);
  }
}
