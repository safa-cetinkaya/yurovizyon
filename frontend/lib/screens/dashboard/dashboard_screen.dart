import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:frontend/models/song.dart';
import 'package:frontend/providers/routes.dart';
import 'package:frontend/providers/storage.dart';
import 'package:frontend/providers/utils.dart';
import 'package:frontend/screens/preference_edit/preference_edit_screen.dart';
import 'package:frontend/screens/settings/settings_screen.dart';
import 'package:frontend/screens/users/users_screen.dart';
import 'package:frontend/services/api/song_api.dart';
import 'package:frontend/widgets/base/base_future_builder.dart';
import 'package:frontend/widgets/base/base_scaffold.dart';

part 'dashboard_view.dart';

class DashboardScreen extends StatefulWidget {
  static const String route = "/dashboard";

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<bool> future;
  late Map<int, Song> songs;

  Future<bool> init() async {
    songs = {};
    for (MapEntry<String, int> entry in Storage.user!.ranking!.entries) {
      var song = await SongAPI.getOne(entry.key);
      song.points = entry.value;

      songs[entry.value] = song;
    }
    songs = SplayTreeMap<int, Song>.from(songs, (a, b) => b.compareTo(a));

    return true;
  }

  @override
  void initState() {
    super.initState();

    future = init();
  }

  void localSetState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => _build(context);
}
