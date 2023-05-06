import 'package:test_base_flutter/data/dto/_base/json.dart';
import 'package:test_base_flutter/data/model/dictionary/dictionary.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dictionary_dto.g.dart';

@JsonSerializable()
class DictionaryDto {
  final int id;
  final String name;
  final int countWords;

  DictionaryDto({
    required this.id,
    required this.name,
    required this.countWords
  });

  Dictionary get model => Dictionary(id: id, name: name, termsCount: countWords);

  factory DictionaryDto.fromJson(Json json) => _$DictionaryDtoFromJson(json);

  Json toJson() => _$DictionaryDtoToJson(this);
}
