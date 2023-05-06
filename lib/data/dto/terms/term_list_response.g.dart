// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermListResponse _$TermListResponseFromJson(Map<String, dynamic> json) =>
    TermListResponse(
      setInfo: DictionaryDto.fromJson(json['setInfo'] as Map<String, dynamic>),
      words: (json['words'] as List<dynamic>)
          .map((e) => TermDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TermListResponseToJson(TermListResponse instance) =>
    <String, dynamic>{
      'setInfo': instance.setInfo,
      'words': instance.words,
    };
