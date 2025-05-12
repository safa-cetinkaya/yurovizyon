import 'package:flutter/material.dart';
import 'package:frontend/models/song.dart';
import 'package:frontend/providers/storage.dart';
import 'package:frontend/providers/utils.dart';
import 'package:frontend/services/api/song_api.dart';
import 'package:frontend/services/api/user_api.dart';
import 'package:frontend/widgets/alert_widgets.dart';
import 'package:frontend/widgets/base/base_app_bar.dart';
import 'package:frontend/widgets/base/base_future_builder.dart';
import 'package:frontend/widgets/base/base_scaffold.dart';

part 'preference_edit_view.dart';

class PreferenceEditScreen extends StatefulWidget {
  static const String route = "/preference_edit";

  const PreferenceEditScreen({super.key});

  @override
  State<PreferenceEditScreen> createState() => _PreferenceEditScreenState();
}

class _PreferenceEditScreenState extends State<PreferenceEditScreen> {
  late Future<List<Song>> future;
  late Map<String, int> ranking;

  Future<List<Song>> getSongs() {
    return SongAPI.getAll();
  }

  Future<void> save() async {
    Storage.user = await UserAPI.editProfile(ranking: ranking);
    AlertWidgets.showSnackbar("Saved!", backgroundColor: Utils.successColor);
  }

  void localSetState() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    ranking = {...(Storage.user!.ranking ?? {})};
    future = getSongs();
  }

  @override
  Widget build(BuildContext context) => _build(context);
}
