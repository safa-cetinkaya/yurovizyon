import 'package:flutter/material.dart';
import 'package:frontend/models/song.dart';
import 'package:frontend/providers/utils.dart';
import 'package:frontend/services/api/base_api.dart';

class SongAPI {
  static const String _oneURL = "/song/get_one";
  static const String _allURL = "/song/get_all";
  static const String _imageURL = "/song/get_image";

  static Future<Song> getOne(String songPk) async {
    return Song.fromJson(
        await BaseAPI.fetch(_oneURL, params: {'song_pk': songPk}));
  }

  static Future<List<Song>> getAll() async {
    List<dynamic> res = await BaseAPI.fetch(_allURL);

    List<Song> songs = [];
    for (var element in res) {
      try {
        songs.add(Song.fromJson(element));
      } catch (_) {}
    }

    return songs;
  }

  static Widget getSongImage(String songPk,
      {bool covered = true, double size = 45.0}) {
    Map<String, String> headers = {'session-id': BaseAPI.sessionId!};
    Map<String, String> params = {'song_pk': songPk};

    bool loaded = false;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: SizedBox.fromSize(
        size: Size.fromRadius(size),
        child: Image.network(
          BaseAPI.baseServer! + _imageURL + BaseAPI.paramsToString(params),
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
        ),
      ),
    );
  }
}
