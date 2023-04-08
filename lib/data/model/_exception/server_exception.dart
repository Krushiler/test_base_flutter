import 'package:test_base_flutter/data/model/_exception/user_exception.dart';

class ServerException extends UserException {
  ServerException.fromJson(Map<String, dynamic> json) : super(json['message']);
}
