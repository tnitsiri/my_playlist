import 'package:json_annotation/json_annotation.dart';

part 'search.result.model.g.dart';

// ANCHOR Search Result Model
@JsonSerializable()
class SearchResultModel {
  String id;
  String songId;
  String songTitle;
  String albumId;
  String albumName;
  List<String> artistsName;
  String? thumbnail;
  String durationText;
  int durationSeconds;

  // ANCHOR Constructor
  SearchResultModel({
    required this.id,
    required this.songId,
    required this.songTitle,
    required this.albumId,
    required this.albumName,
    required this.artistsName,
    this.thumbnail,
    required this.durationText,
    required this.durationSeconds,
  });

  // ANCHOR From Json
  factory SearchResultModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return _$SearchResultModelFromJson(
      json,
    );
  }

  // ANCHOR To Json
  Map<String, dynamic> toJson() {
    return _$SearchResultModelToJson(
      this,
    );
  }
}
