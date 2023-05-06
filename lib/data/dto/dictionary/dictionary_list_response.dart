import 'package:test_base_flutter/data/dto/_base/json.dart';
import 'package:test_base_flutter/data/dto/dictionary/dictionary_dto.dart';
import 'package:test_base_flutter/data/model/dictionary/dictionary_list_result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dictionary_list_response.g.dart';

@JsonSerializable()
class DictionaryListResponse {
  final List<DictionaryDto> data;

  DictionaryListResponse({required this.data});

  DictionaryListResult get model => DictionaryListResult(
        data.map((e) => e.model).toList(),
      );

  factory DictionaryListResponse.fromJson(Json json) => _$DictionaryListResponseFromJson(json);

  Json toJson() => _$DictionaryListResponseToJson(this);
}
