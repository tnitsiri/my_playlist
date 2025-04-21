// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.result.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultModel _$SearchResultModelFromJson(Map<String, dynamic> json) =>
    SearchResultModel(
      id: json['id'] as String,
      songId: json['songId'] as String,
      songTitle: json['songTitle'] as String,
      albumId: json['albumId'] as String,
      albumName: json['albumName'] as String,
      artistsName: (json['artistsName'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      thumbnail: json['thumbnail'] as String?,
      durationText: json['durationText'] as String,
      durationSeconds: (json['durationSeconds'] as num).toInt(),
    );

Map<String, dynamic> _$SearchResultModelToJson(SearchResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'songId': instance.songId,
      'songTitle': instance.songTitle,
      'albumId': instance.albumId,
      'albumName': instance.albumName,
      'artistsName': instance.artistsName,
      'thumbnail': instance.thumbnail,
      'durationText': instance.durationText,
      'durationSeconds': instance.durationSeconds,
    };
