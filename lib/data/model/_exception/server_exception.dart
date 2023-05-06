import 'package:test_base_flutter/data/model/_exception/user_exception.dart';

class ServerException extends UserException {
  ServerException(String message) : super(message);

  ServerException.fromJson(Map<String, dynamic> json)
      : super(json['errorMessage']);
}
