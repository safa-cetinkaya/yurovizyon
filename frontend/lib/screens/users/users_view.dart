part of 'users_screen.dart';

extension UsersView on _UsersScreenState {
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
                'Users',
                style: TextStyle(
                  color: Utils.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
      body: BaseFutureBuilder<bool>(
        future: future,
        childFunction: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListView(
              children: [
                for (MapEntry entry in usersAndRankings.entries)
                  userBox(entry.key, entry.value)
              ],
            ),
          );
        },
      ),
    );
  }

  Container userBox(User user, Song? song) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Utils.foregroundColor.withOpacity(.5),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundImage: Image.asset(
              'assets/images/${user.profileImage}.jpg',
            ).image,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Utils.textColor,
                    size: 16,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    user.username,
                    style: TextStyle(
                      color: Utils.textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.attachment,
                    color: Utils.textColor.withAlpha(130),
                    size: 16,
                  ),
                  const SizedBox(width: 4.0),
                  SizedBox(
                    width: 90,
                    height: 50,
                    child: SingleChildScrollView(
                      child: Text(
                        user.bio ?? '',
                        style: TextStyle(color: Utils.textColor, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 18.0),
          Stack(
            children: [
              if (song != null)
                SongAPI.getSongImage(song.songPk, size: 35)
              else
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                    width: 70,
                    height: 70,
                    color: const Color.fromARGB(255, 23, 23, 23),
                  ),
                ),
              Positioned(
                right: 7.0,
                bottom: 3.0,
                child: Text(
                  '#1',
                  style: TextStyle(
                    color: Utils.inactiveColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 6.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.music_note,
                    color: Utils.textColor,
                    size: 16,
                  ),
                  const SizedBox(width: 2.0),
                  SizedBox(
                    width: 70,
                    child: Text(
                      song != null ? song.name : '#Empty',
                      style: TextStyle(
                        color: Utils.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  Icon(
                    Icons.south_america,
                    color: Utils.textColor,
                    size: 16,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    song != null ? song.country : '#Empty',
                    style: TextStyle(
                      color: Utils.textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
