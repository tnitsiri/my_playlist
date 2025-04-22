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

  late final _$mediasAtom =
      Atom(name: 'PlayerStoreBase.medias', context: context);

  @override
  List<MediaItem> get medias {
    _$mediasAtom.reportRead();
    return super.medias;
  }

  bool _mediasIsInitialized = false;

  @override
  set medias(List<MediaItem> value) {
    _$mediasAtom.reportWrite(value, _mediasIsInitialized ? super.medias : null,
        () {
      super.medias = value;
      _mediasIsInitialized = true;
    });
  }

  late final _$playAsyncAction =
      AsyncAction('PlayerStoreBase.play', context: context);

  @override
  Future<void> play(
      {required PlaylistModel playlist, required List<SongModel> songs}) {
    return _$playAsyncAction
        .run(() => super.play(playlist: playlist, songs: songs));
  }

  @override
  String toString() {
    return '''
audioHandler: ${audioHandler},
medias: ${medias}
    ''';
  }
}
