import 'package:flutter/cupertino.dart';

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
          ),
        ],
      ),
    );
  }
}
