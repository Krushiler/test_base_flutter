import 'package:json_annotation/json_annotation.dart';
import 'package:test_base_flutter/data/dto/_base/json.dart';
import 'package:test_base_flutter/data/dto/dictionary/dictionary_dto.dart';
import 'package:test_base_flutter/data/dto/terms/term_dto.dart';
import 'package:test_base_flutter/data/model/terms/term_list_result.dart';

part 'term_list_response.g.dart';

@JsonSerializable()
class TermListResponse {
  final DictionaryDto setInfo;
  final List<TermDto> words;

  TermListResponse({
    required this.setInfo,
    required this.words,
  });

  TermListResult get model => TermListResult(
        setInfo.name,
        words.map((e) => e.model).toList(),
      );

  factory TermListResponse.fromJson(Json json) => _$TermListResponseFromJson(json);

  Json toJson() => _$TermListResponseToJson(this);
}
