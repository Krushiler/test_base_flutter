import 'package:json_annotation/json_annotation.dart';
import 'package:test_base_flutter/data/dto/_base/json.dart';
import 'package:test_base_flutter/data/model/terms/term.dart';

part 'term_dto.g.dart';

@JsonSerializable()
class TermDto {
  final int id;
  final String word;
  final String translate;
  final String description;

  TermDto({
    required this.id,
    required this.word,
    required this.translate,
    required this.description,
  });

  Term get model => Term(
        id: id,
        name: word,
        translation: translate,
        description: description,
      );

  factory TermDto.fromJson(Json json) => _$TermDtoFromJson(json);

  Json toJson() => _$TermDtoToJson(this);
}
