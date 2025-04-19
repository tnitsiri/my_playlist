// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistModel _$PlaylistModelFromJson(Map<String, dynamic> json) =>
    PlaylistModel(
      id: json['id'] as String,
      title: json['title'] as String,
      songs: (json['songs'] as List<dynamic>)
          .map((e) => SongModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaylistModelToJson(PlaylistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'songs': instance.songs,
    };
