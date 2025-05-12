import 'package:flutter/material.dart';
import 'package:frontend/models/song.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/providers/utils.dart';
import 'package:frontend/services/api/song_api.dart';
import 'package:frontend/services/api/user_api.dart';
import 'package:frontend/widgets/base/base_app_bar.dart';
import 'package:frontend/widgets/base/base_future_builder.dart';
import 'package:frontend/widgets/base/base_scaffold.dart';

part 'users_view.dart';

class UsersScreen extends StatefulWidget {
  static const String route = "/users";

  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late Future<bool> future;
  Map<User, Song?> usersAndRankings = {};

  Future<bool> init() async {
    List<User> users = await UserAPI.getUsers();

    for (var user in users) {
      Song? first;

      for (var ranking in (user.ranking ?? {}).entries) {
        if (ranking.value == 12) {
          first = await SongAPI.getOne(ranking.key);
        }
      }

      usersAndRankings[user] = first;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();

    future = init();
  }

  @override
  Widget build(BuildContext context) => _build(context);
}
