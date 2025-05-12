part of 'preference_edit_screen.dart';

extension PreferenceEditView on _PreferenceEditScreenState {
  Widget _build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        height: 38,
        child: Stack(
          children: [
            BaseAppBar.backButton(),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Preference Edit',
                style: TextStyle(
                  color: Utils.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: BaseAppBar.iconButton(icon: Icons.save, onTap: save),
            ),
          ],
        ),
      ),
      body: Center(
        child: BaseFutureBuilder<List<Song>>(
            future: future,
            childFunction: (snapshot) {
              List<Song> songs = snapshot.data!;

              return Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 300,
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GridView.count(
                      crossAxisCount: 3,
                      children: [
                        for (Song song in songs)
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: AbsorbPointer(
                              absorbing: ranking.keys.contains(song.songPk),
                              child: Opacity(
                                opacity: ranking.keys.contains(song.songPk)
                                    ? 0.5
                                    : 1.0,
                                child: Draggable(
                                  data: song,
                                  childWhenDragging: Opacity(
                                    opacity: .75,
                                    child: SongAPI.getSongImage(song.songPk),
                                  ),
                                  feedback: SongAPI.getSongImage(song.songPk),
                                  child: SongAPI.getSongImage(song.songPk),
                                ),
                              ),
                            ),
                          )
                      ],
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GridView.count(
                        crossAxisCount: 3,
                        children: [
                          for (int key in Utils.orderMap.keys)
                            songDragTarget(Utils.orderMap[key]!, key)
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }

  DragTarget<Song> songDragTarget(String order, int points) {
    return DragTarget<Song>(
      onAccept: (song) {
        for (String key in [...(ranking.keys)]) {
          if (ranking[key] == points) {
            ranking.remove(key);
          }
        }

        ranking[song.songPk] = points;
        localSetState();
      },
      builder: (context, candidateData, rejectedData) {
        return Opacity(
          opacity: candidateData.isEmpty ? 1.0 : 0.9,
          child: Container(
            width: 125,
            height: 130,
            margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
            padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Utils.foregroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '#$order ($points Points)',
                      style: TextStyle(
                        color: Utils.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    if (ranking.values.contains(points))
                      GestureDetector(
                        onTap: () {
                          ranking.removeWhere((key, value) => value == points);
                          localSetState();
                        },
                        child: SongAPI.getSongImage(ranking.entries
                            .firstWhere((element) => element.value == points)
                            .key),
                      )
                    else
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          width: 90,
                          height: 90,
                          color: const Color.fromARGB(255, 23, 23, 23),
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
