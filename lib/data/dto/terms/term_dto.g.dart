// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermDto _$TermDtoFromJson(Map<String, dynamic> json) => TermDto(
      id: json['id'] as int,
      word: json['word'] as String,
      translate: json['translate'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$TermDtoToJson(TermDto instance) => <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'translate': instance.translate,
      'description': instance.description,
    };
