import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:frontend/models/song.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/providers/utils.dart';
import 'package:frontend/services/api/song_api.dart';
import 'package:frontend/services/api/user_api.dart';
import 'package:frontend/widgets/base/base_app_bar.dart';
import 'package:frontend/widgets/base/base_future_builder.dart';
import 'package:frontend/widgets/base/base_scaffold.dart';

part 'user_ranking_view.dart';

class UserRankingScreen extends StatefulWidget {
  static const String route = "/user_ranking";
  final String userPk;

  const UserRankingScreen({required this.userPk, super.key});

  @override
  State<UserRankingScreen> createState() => _UserRankingScreenState();
}

class _UserRankingScreenState extends State<UserRankingScreen> {
  late Future<bool> future;

  User? user;
  late Map<int, Song> songs;

  Future<bool> init() async {
    user = User.fromJson(await UserAPI.info(userPk: widget.userPk));

    songs = {};
    for (MapEntry<String, int> entry in user!.ranking!.entries) {
      var song = await SongAPI.getOne(entry.key);
      song.points = entry.value;

      songs[entry.value] = song;
    }
    songs = SplayTreeMap<int, Song>.from(songs, (a, b) => b.compareTo(a));

    setState(() {});

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
