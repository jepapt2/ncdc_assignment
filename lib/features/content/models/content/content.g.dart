// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentImpl _$$ContentImplFromJson(Map<String, dynamic> json) =>
    _$ContentImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String?,
      body: json['body'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ContentImplToJson(_$ContentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$CreateContentDTOImpl _$$CreateContentDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateContentDTOImpl(
      title: json['title'] as String?,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$$CreateContentDTOImplToJson(
        _$CreateContentDTOImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
    };
