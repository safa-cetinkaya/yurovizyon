import 'package:flutter/material.dart';
import 'package:frontend/providers/storage.dart';
import 'package:frontend/providers/utils.dart';
import 'package:frontend/services/api/user_api.dart';
import 'package:frontend/widgets/alert_widgets.dart';
import 'package:frontend/widgets/base/base_app_bar.dart';
import 'package:frontend/widgets/base/base_scaffold.dart';
import 'package:frontend/widgets/input_widgets.dart';

part 'profile_edit_view.dart';

class ProfileEditScreen extends StatefulWidget {
  static const String route = "/profile_edit";

  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final List<String> songNames = [
    'the_code',
    'rim_tim',
    'no_rules',
    'liar',
    'zari',
    'mon_amour',
    '11_11',
    'before_party',
    'ramonda',
    'teresa',
    'unforgettable',
    'veronika',
    'zorra',
    'rave',
    'jako',
    'firefighter',
    'on_run',
    'doomsday',
    'la_noia',
    'luktelk',
    'fighter',
  ];

  late String selectedImage, name, surname, bio;
  bool loading = false;

  void localSetState() {
    setState(() {});
  }

  Future<void> save() async {
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() => loading = true);
    try {
      Storage.user = await UserAPI.editProfile(
          name: name, surname: surname, bio: bio, profileImage: selectedImage);
      AlertWidgets.showSnackbar("Saved!", backgroundColor: Utils.successColor);
    } catch (_) {}
    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();

    name = Storage.user!.name ?? '';
    surname = Storage.user!.surname ?? '';
    bio = Storage.user!.bio ?? '';
    selectedImage = Storage.user!.profileImage ?? '';
  }

  @override
  Widget build(BuildContext context) => _build(context);
}
