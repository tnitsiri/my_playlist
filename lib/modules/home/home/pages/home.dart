import 'package:flutter/cupertino.dart';
import 'package:iconly/iconly.dart';
import 'package:my_playlist/enums/form.enum.dart';
import 'package:my_playlist/modules/playlist/form/pages/form.dart';
import 'package:my_playlist/views/buttons/button.dart';

// ANCHOR Home Page
class HomePage extends StatefulWidget {
  // ANCHOR Constructor
  const HomePage({
    super.key,
  });

  // ANCHOR Create State
  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

// ANCHOR Home Page State
class _HomePageState extends State<HomePage> {
  // ANCHOR Create
  void _create() async {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (
          BuildContext context,
        ) {
          return PlaylistFormPage(
            mode: FormModeEnum.create,
          );
        },
      ),
    );
  }

  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text(
              'My Playlist',
            ),
            trailing: Button(
              icon: IconlyLight.plus,
              onPressed: _create,
            ),
          ),
        ],
      ),
    );
  }
}
