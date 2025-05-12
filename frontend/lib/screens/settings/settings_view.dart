part of 'settings_screen.dart';

extension SettingsView on _SettingsScreenState {
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
                'Settings',
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10.0),
            Container(
              height: 100,
              width: double.infinity,
              margin:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              decoration: BoxDecoration(
                color: Utils.foregroundColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: Image.asset(
                          'assets/images/${Storage.user!.profileImage}.jpg',
                        ).image,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${Storage.user!.name} ${Storage.user!.surname}",
                              style: TextStyle(
                                  color: Utils.textColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Utils.inactiveColor,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  Storage.user!.username,
                                  style: TextStyle(
                                      color: Utils.inactiveColor, fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await Routes.pushNamed(ProfileEditScreen.route);
                      localSetState();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Utils.primaryColor,
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.edit,
                        color: Utils.textColor,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 136,
              width: double.infinity,
              margin:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              decoration: BoxDecoration(
                color: Utils.foregroundColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  settingsTile(
                      onPressed: () {},
                      icon: Icons.shield,
                      title: 'Privacy & Security'),
                  settingsTile(
                      onPressed: () {},
                      icon: Icons.mark_chat_unread,
                      title: 'Notification Preference'),
                  settingsTile(
                      onPressed: () {},
                      icon: Icons.language,
                      title: 'Language'),
                ],
              ),
            ),
            Container(
              height: 56,
              width: double.infinity,
              margin:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              decoration: BoxDecoration(
                color: Utils.foregroundColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  settingsTile(
                      onPressed: () async {
                        await AuthAPI.logout();

                        Routes.pushNamed(LoginScreen.route);
                        AlertWidgets.showSnackbar("Logged out!",
                            backgroundColor: Utils.successColor);
                      },
                      icon: Icons.logout,
                      title: 'Log Out'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding settingsTile(
      {required IconData icon,
      required String title,
      required void Function() onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Utils.textColor,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(color: Utils.textColor, fontSize: 14),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Utils.textColor,
              size: 12,
            )
          ],
        ),
      ),
    );
  }
}
