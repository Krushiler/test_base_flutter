// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DictionaryListResponse _$DictionaryListResponseFromJson(
        Map<String, dynamic> json) =>
    DictionaryListResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => DictionaryDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DictionaryListResponseToJson(
        DictionaryListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
