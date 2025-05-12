part of 'dashboard_screen.dart';

extension DashboardView on _DashboardScreenState {
  Widget _build(BuildContext context) {
    return BaseScaffold(
      body: Center(
        child: BaseFutureBuilder<bool>(
            future: future,
            childFunction: (snapshot) {
              return Column(
                children: [
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 6.0),
                            GestureDetector(
                              onTap: () => Routes.pushNamed(UsersScreen.route),
                              child: Icon(
                                Icons.person,
                                size: 28,
                                color: Utils.textColor,
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: Image.asset(
                              'assets/images/${Storage.user!.profileImage}.jpg',
                            ).image,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await Routes.pushNamed(
                                    PreferenceEditScreen.route);
                                future = init();
                                localSetState();
                              },
                              child: Icon(
                                Icons.edit,
                                size: 28,
                                color: Utils.textColor,
                              ),
                            ),
                            const SizedBox(width: 6.0),
                            GestureDetector(
                              onTap: () async {
                                await Routes.pushNamed(SettingsScreen.route);
                                future = init();
                                localSetState();
                              },
                              child: Icon(
                                Icons.settings,
                                size: 28,
                                color: Utils.textColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Text(
                    Storage.user!.username,
                    style: TextStyle(
                      color: Utils.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    Storage.user!.bio ?? '',
                    style: TextStyle(
                      color: Utils.textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, bottom: 8.0, right: 10.0, left: 10.0),
                    child: Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Utils.textColor,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (songs[10] == null)
                        emptyRankingBox(order: 2, size: 120)
                      else
                        SongAPI.getSongImage(songs[10]!.songPk, size: 60),
                      const SizedBox(width: 6.0),
                      if (songs[12] == null)
                        emptyRankingBox(order: 1, size: 140)
                      else
                        SongAPI.getSongImage(songs[12]!.songPk, size: 70),
                      const SizedBox(width: 6.0),
                      if (songs[9] == null)
                        emptyRankingBox(order: 3, size: 100)
                      else
                        SongAPI.getSongImage(songs[9]!.songPk, size: 50),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListView(
                        children: [
                          for (int i = 0; i < songs.length; i++)
                            if (songs.values.toList()[i].points! < 9)
                              songRow(song: songs.values.toList()[i])
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  ClipRRect emptyRankingBox({required int order, required double size}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        width: size,
        height: size,
        color: const Color.fromARGB(255, 23, 23, 23),
        child: Text('#$order', style: TextStyle(color: Utils.textColor)),
      ),
    );
  }

  Widget songRow({
    required Song song,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SongAPI.getSongImage(song.songPk),
          const SizedBox(width: 16.0),
          SizedBox(
            height: 100.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '#${Utils.orderMap[song.points]} (${song.points} Points)',
                  style: TextStyle(
                    color: Utils.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 6.0),
                Row(
                  children: [
                    Icon(
                      Icons.music_note,
                      color: Utils.textColor,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      song.name,
                      style: TextStyle(
                        color: Utils.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Utils.textColor,
                      size: 16,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      '${song.artist}  |  ',
                      style: TextStyle(
                        color: Utils.textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    Icon(
                      Icons.lock_clock,
                      color: Utils.textColor,
                      size: 16,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      '${song.length ~/ 60}m ${song.length % 60}s',
                      style: TextStyle(
                        color: Utils.textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.south_america,
                      color: Utils.textColor,
                      size: 16,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      song.country,
                      style: TextStyle(
                        color: Utils.textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
