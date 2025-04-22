import 'package:audio_service/audio_service.dart';
import 'package:mobx/mobx.dart';
import 'package:my_playlist/models/playlist.model.dart';
import 'package:my_playlist/models/song.model.dart';
import 'package:my_playlist/plugins/audio/a.dart';

part 'player.store.g.dart';

// ANCHOR Player Store
class PlayerStore = PlayerStoreBase with _$PlayerStore;

// ANCHOR Player Store Base
abstract class PlayerStoreBase with Store {
  final AudioPlayerHandler _audioHandler;

  PlayerStoreBase(
    this._audioHandler,
  ) {
    audioHandler = _audioHandler;
  }

  // ANCHOR Audio Handler
  @observable
  late AudioPlayerHandler audioHandler;

  // ANCHOR Medias
  @observable
  late List<MediaItem> medias = [];

  // ANCHOR Play
  @action
  Future<void> play({
    required PlaylistModel playlist,
    required List<SongModel> songs,
  }) async {
    await audioHandler.stop();

    List<MediaItem> queue = [];

    for (SongModel song in songs) {
      queue.add(
        song.mediaItem,
      );
    }

    await audioHandler.updateQueue(
      queue,
    );

    await audioHandler.play();
  }
}
