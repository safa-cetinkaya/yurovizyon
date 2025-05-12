part of 'profile_edit_screen.dart';

extension ProfileEditView on _ProfileEditScreenState {
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
                'Profile Edit',
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
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 70,
                backgroundImage: Image.asset(
                  'assets/images/$selectedImage.jpg',
                ).image,
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              height: 100,
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (String name in songNames) profileSelectable(name),
                ],
              ),
            ),
            AbsorbPointer(
              absorbing: true,
              child: Opacity(
                opacity: .5,
                child: InputWidget(
                  hintText: 'Username',
                  initialValue: Storage.user!.username,
                ),
              ),
            ),
            InputWidget(
              hintText: 'Name',
              initialValue: name,
              onChanged: (q) => name = q,
            ),
            InputWidget(
              hintText: 'Surname',
              initialValue: surname,
              onChanged: (q) => surname = q,
            ),
            InputWidget(
              hintText: 'Biography',
              initialValue: bio,
              onChanged: (q) => bio = q,
            ),
            const SizedBox(height: 8.0),
            ButtonWidget(
              text: 'Save',
              width: 200,
              backgroundColor: Utils.primaryColor,
              onPressed: loading ? null : save,
            ),
          ],
        ),
      ),
    );
  }

  Widget profileSelectable(String path) {
    return Stack(
      children: [
        if (path == selectedImage)
          const Positioned(
            right: 26,
            top: 18,
            child: Icon(
              Icons.done,
              color: Color.fromARGB(255, 0, 206, 7),
              size: 36,
            ),
          ),
        AbsorbPointer(
          absorbing: path == selectedImage,
          child: Opacity(
            opacity: path == selectedImage ? .5 : 1.0,
            child: GestureDetector(
              onTap: () {
                selectedImage = path;
                localSetState();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: Image.asset(
                    'assets/images/$path.jpg',
                  ).image,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
