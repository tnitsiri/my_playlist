import 'package:json_annotation/json_annotation.dart';
import 'package:my_playlist/models/song.model.dart';

part 'playlist.model.g.dart';

// ANCHOR Playlist Model
@JsonSerializable()
class PlaylistModel {
  String id;
  String title;
  List<SongModel> songs;

  // ANCHOR Constructor
  PlaylistModel({
    required this.id,
    required this.title,
    required this.songs,
  });

  // ANCHOR From Json
  factory PlaylistModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return _$PlaylistModelFromJson(
      json,
    );
  }

  // ANCHOR To Json
  Map<String, dynamic> toJson() {
    return _$PlaylistModelToJson(
      this,
    );
  }
}
