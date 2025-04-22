// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlayerStore on PlayerStoreBase, Store {
  late final _$audioHandlerAtom =
      Atom(name: 'PlayerStoreBase.audioHandler', context: context);

  @override
  AudioPlayerHandler get audioHandler {
    _$audioHandlerAtom.reportRead();
    return super.audioHandler;
  }

  bool _audioHandlerIsInitialized = false;

  @override
  set audioHandler(AudioPlayerHandler value) {
    _$audioHandlerAtom.reportWrite(
        value, _audioHandlerIsInitialized ? super.audioHandler : null, () {
      super.audioHandler = value;
      _audioHandlerIsInitialized = true;
    });
  }

  late final _$playlistAtom =
      Atom(name: 'PlayerStoreBase.playlist', context: context);

  @override
  PlaylistModel? get playlist {
    _$playlistAtom.reportRead();
    return super.playlist;
  }

  @override
  set playlist(PlaylistModel? value) {
    _$playlistAtom.reportWrite(value, super.playlist, () {
      super.playlist = value;
    });
  }

  late final _$playAsyncAction =
      AsyncAction('PlayerStoreBase.play', context: context);

  @override
  Future<void> play(
      {required PlaylistModel playlist,
      required List<SongModel> songs,
      bool play = true,
      int? index}) {
    return _$playAsyncAction.run(() =>
        super.play(playlist: playlist, songs: songs, play: play, index: index));
  }

  late final _$updateAsyncAction =
      AsyncAction('PlayerStoreBase.update', context: context);

  @override
  Future<void> update({required List<SongModel> songs}) {
    return _$updateAsyncAction.run(() => super.update(songs: songs));
  }

  late final _$appendAsyncAction =
      AsyncAction('PlayerStoreBase.append', context: context);

  @override
  Future<void> append({required List<SongModel> songs}) {
    return _$appendAsyncAction.run(() => super.append(songs: songs));
  }

  late final _$clearAsyncAction =
      AsyncAction('PlayerStoreBase.clear', context: context);

  @override
  Future<void> clear() {
    return _$clearAsyncAction.run(() => super.clear());
  }

  @override
  String toString() {
    return '''
audioHandler: ${audioHandler},
playlist: ${playlist}
    ''';
  }
}
