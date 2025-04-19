import 'package:json_annotation/json_annotation.dart';

part 'song.model.g.dart';

// ANCHOR Song Model
@JsonSerializable()
class SongModel {
  String id;

  // ANCHOR Constructor
  SongModel({
    required this.id,
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
