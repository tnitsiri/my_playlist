import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

part 'playlist.store.g.dart';

// ANCHOR Playlist Store
class PlaylistStore = PlaylistStoreBase with _$PlaylistStore;

// ANCHOR Playlist Store Base
abstract class PlaylistStoreBase with Store {
  // ANCHOR State
  final Uuid _uuid = const Uuid();

  // ANCHOR Fetch List Token
  @observable
  String? fetchListToken;

  // ANCHOR Fetch List
  @action
  void fetchList() {
    fetchListToken = _uuid.v1();
  }
}
