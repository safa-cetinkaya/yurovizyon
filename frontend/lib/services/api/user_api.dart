import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/models/session.dart';
import 'package:frontend/providers/storage.dart';
import 'package:frontend/providers/utils.dart';
import 'package:frontend/services/api/base_api.dart';

class UserAPI {
  static const String _infoURL = "/user/information";
  static const String _usersURL = "/user/get_users";
  static const String _sessionsURL = "/user/get_sessions";
  static const String _editProfileURL = "/user/edit_profile";
  static const String _profileImageURL = "/user/profile_picture";

  static Future<Map<String, dynamic>> info({String? userPk}) async {
    Map<String, String> params = {};
    if (userPk != null) {
      params['user_pk'] = userPk;
    }

    return await BaseAPI.fetch(_infoURL, params: params);
  }

  static Future<List<User>> getUsers() async {
    List<dynamic> res = await BaseAPI.fetch(_usersURL);

    List<User> users = [];
    for (var element in res) {
      try {
        users.add(User.fromJson(element));
      } catch (e) {
        log(e.toString());
      }
    }

    return users;
  }

  static Future<List<Session>> getSessions(int userFK) async {
    List<Map<String, dynamic>> res = await BaseAPI.fetch(_sessionsURL,
        params: {'userFK': userFK.toString()});

    List<Session> sessions = [];
    for (var element in res) {
      try {
        sessions.add(Session.fromJson(element));
      } catch (e) {
        log(e.toString());
      }
    }

    return sessions;
  }

  static Future<User> editProfile({
    // TODO photos are set. Only index would be enough.
    String? name,
    String? surname,
    String? bio,
    String? profileImage,
    Map<String, int>? ranking,
    int deleted = 0,
  }) async {
    Map<String, String> body = {};
    if (name != null && name.isNotEmpty) body['name'] = name;
    if (surname != null && surname.isNotEmpty) body['surname'] = surname;
    if (bio != null) body['bio'] = bio;
    if (ranking != null) body['ranking'] = jsonEncode(ranking);

    if (profileImage != null) body['profile_image'] = profileImage;
    body['deleted'] = deleted.toString();

    Map<String, dynamic> res = await BaseAPI.fetch(_editProfileURL,
        body: body, requestType: RequestType.post);
    return User.fromJson(res);
  }

  static Widget getProfileImage(String? profileImage,
      {bool covered = true,
      double? size,
      double? radius,
      String? name,
      double? fontSize}) {
    if (profileImage == null) {
      return profileErrorWidget(radius, name: name, fontSize: fontSize);
    }

    Map<String, String> headers = {'session-id': BaseAPI.sessionId!};
    Map<String, String> params = {'profile-image': profileImage.toString()};
    if (size != null) {
      params['size'] = size.toString();
    }

    bool loaded = false;

    return CircleAvatar(
      radius: (radius ?? 100.0),
      backgroundColor: Utils.primaryColor,
      backgroundImage: Image.network(
        BaseAPI.baseServer! + _profileImageURL + BaseAPI.paramsToString(params),
        fit: covered ? BoxFit.cover : BoxFit.contain,
        headers: headers,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          loaded = frame != null;
          return child;
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loaded && loadingProgress == null) return child;
          return Center(
              child: CircularProgressIndicator(color: Utils.textColor));
        },
        errorBuilder: (context, error, stackTrace) {
          return profileErrorWidget(radius);
        },
      ).image,
    );
  }

  static Widget profileErrorWidget(double? radius,
      {String? name, double? fontSize}) {
    String username = name ?? Storage.user!.username;
    String profileImageText = "";

    for (String i in username.split(" ")) {
      profileImageText += i[0].toUpperCase();
    }

    return CircleAvatar(
      radius: radius ?? 100.0,
      backgroundColor: Utils.primaryColor,
      child: Center(
        child: Text(
          profileImageText,
          style: TextStyle(
              color: Utils.textColor,
              fontSize: fontSize ?? 20,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
