import 'dart:convert';

class User {
  String userPk, username;
  String? profileImage, name, surname, password, bio;
  int level, state;
  Map<String, int>? ranking;

  User({
    required this.userPk,
    required this.username,
    required this.level,
    this.state = 1,
    this.profileImage,
    this.bio,
    this.name,
    this.surname,
    this.password,
    this.ranking,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      state: (json['state'] is String)
          ? int.parse(json['state'])
          : json['state'] ?? 1,
      userPk: json['user_pk'],
      username: json['username'],
      name: json['name'],
      surname: json['surname'],
      bio: json['bio'],
      profileImage: json['profile_image'],
      level:
          (json['level'] is String) ? int.parse(json['level']) : json['level'],
      ranking: (json['ranking'] is String)
          ? Map<String, int>.from(jsonDecode(json['ranking']))
          : {},
    );
  }
}
