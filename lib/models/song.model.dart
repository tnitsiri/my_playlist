import 'package:audio_service/audio_service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'song.model.g.dart';

// ANCHOR Song Model
@JsonSerializable()
class SongModel {
  String id;
  String songId;
  String songTitle;
  String albumId;
  String albumName;
  List<String> artistsName;
  String? thumbnail;
  String durationText;
  int durationSeconds;
  String pathname;
  String url;

  // ANCHOR Constructor
  SongModel({
    required this.id,
    required this.songId,
    required this.songTitle,
    required this.albumId,
    required this.albumName,
    required this.artistsName,
    this.thumbnail,
    required this.durationText,
    required this.durationSeconds,
    required this.pathname,
    required this.url,
  });

  // ANCHOR From Json
  factory SongModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return _$SongModelFromJson(
      json,
    );
  }

  // ANCHOR To Json
  Map<String, dynamic> toJson() {
    return _$SongModelToJson(
      this,
    );
  }

  // ANCHOR Media Item
  MediaItem get mediaItem {
    // artist
    String? artist;

    if (artistsName.isNotEmpty) {
      artist = artistsName.join(', ');
    }

    // art uri
    Uri? artUri;

    if (thumbnail != null) {
      artUri = Uri.parse(
        thumbnail!,
      );
    }

    // media item
    MediaItem mediaItem = MediaItem(
      id: url,
      title: songTitle,
      album: albumName,
      artist: artist,
      duration: Duration(
        seconds: durationSeconds,
      ),
      artUri: artUri,
    );

    return mediaItem;
  }
}
