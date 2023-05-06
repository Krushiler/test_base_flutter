// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DictionaryDto _$DictionaryDtoFromJson(Map<String, dynamic> json) =>
    DictionaryDto(
      id: json['id'] as int,
      name: json['name'] as String,
      countWords: json['countWords'] as int,
    );

Map<String, dynamic> _$DictionaryDtoToJson(DictionaryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'countWords': instance.countWords,
    };
