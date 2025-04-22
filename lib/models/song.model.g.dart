// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongModel _$SongModelFromJson(Map<String, dynamic> json) => SongModel(
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
      pathname: json['pathname'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$SongModelToJson(SongModel instance) => <String, dynamic>{
      'id': instance.id,
      'songId': instance.songId,
      'songTitle': instance.songTitle,
      'albumId': instance.albumId,
      'albumName': instance.albumName,
      'artistsName': instance.artistsName,
      'thumbnail': instance.thumbnail,
      'durationText': instance.durationText,
      'durationSeconds': instance.durationSeconds,
      'pathname': instance.pathname,
      'url': instance.url,
    };
