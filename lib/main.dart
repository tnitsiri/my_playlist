import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_playlist/app.dart';
import 'package:my_playlist/plugins/audio/a.dart';
import 'package:my_playlist/plugins/audio/c.dart';

// ANCHOR Main
void main() async {
  // audio handler
  AudioPlayerHandler audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandlerImpl(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    ),
  );

  // app
  runApp(
    App(
      audioHandler: audioHandler,
    ),
  );
}
