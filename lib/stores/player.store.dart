import 'package:audio_service/audio_service.dart';
import 'package:mobx/mobx.dart';
import 'package:my_playlist/models/playlist.model.dart';
import 'package:my_playlist/models/song.model.dart';
import 'package:my_playlist/plugins/audio/player.dart';

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

  // ANCHOR Playlist
  @observable
  PlaylistModel? playlist;

  // ANCHOR Play
  @action
  Future<void> play({
    required PlaylistModel playlist,
    required List<SongModel> songs,
    bool play = true,
    int? index,
  }) async {
    this.playlist = playlist;

    await audioHandler.stop();
    await update(
      songs: songs,
    );

    if (play) {
      if (index != null && index > -1 && index <= songs.length - 1) {
        await audioHandler.skipToQueueItem(
          index,
        );
      }

      await audioHandler.play();
    }
  }

  // ANCHOR Update
  @action
  Future<void> update({
    required List<SongModel> songs,
  }) async {
    List<MediaItem> queue = [];

    for (SongModel song in songs) {
      queue.add(
        song.mediaItem,
      );
    }

    await audioHandler.updateQueue(
      queue,
    );
  }

  // ANCHOR Append
  @action
  Future<void> append({
    required List<SongModel> songs,
  }) async {
    List<MediaItem> queue = [];

    for (SongModel song in songs) {
      queue.add(
        song.mediaItem,
      );
    }

    await audioHandler.addQueueItems(
      queue,
    );
  }

  // ANCHOR Clear
  @action
  Future<void> clear() async {
    await audioHandler.stop();
    await audioHandler.updateQueue([]);

    playlist = null;
  }
}
