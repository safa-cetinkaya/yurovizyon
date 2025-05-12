class Song {
  String songPk, name, artist, country, imagePath;
  int length, state;
  int? points;

  Song({
    required this.state,
    required this.songPk,
    required this.name,
    required this.artist,
    required this.country,
    required this.length,
    required this.imagePath,
    this.points,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      state: (json['state'] is String)
          ? int.parse(json['state'])
          : json['state'] ?? 1,
      songPk: json['song_pk'],
      name: json['name'],
      artist: json['artist'],
      country: json['country'],
      length: json['length'],
      imagePath: json['image_path'],
    );
  }
}
