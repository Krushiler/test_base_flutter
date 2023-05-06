import 'package:test_base_flutter/data/model/_exception/server_exception.dart';

class ResponseDto {
  late final bool success;
  late final ServerException? exception;

  ResponseDto.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool;
    exception = json.containsKey('errorMessage') && json['errorMessage'] != null
        ? ServerException.fromJson(json)
        : null;
  }
}
