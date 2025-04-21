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
  String filePathname;
  String fileUrl;

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
    required this.filePathname,
    required this.fileUrl,
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
}
