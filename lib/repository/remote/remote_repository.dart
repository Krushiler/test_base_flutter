import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:test_base_flutter/data/dto/_base/response_dto.dart';
import 'package:test_base_flutter/data/model/_exception/server_exception.dart';

abstract class RemoteRepository {
  static const token = 'pizdec';

  Future<Either<ServerException, Map<String, dynamic>>> executePost(
      String action, Map<String, dynamic> payload) async {
    var url = Uri.parse('192.168.0.1:8080/api/$action');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(payload));

    final body = json.decode(response.body);
    final baseResponse = ResponseDto.fromJson(body);

    if (!baseResponse.success) {
      return Left(baseResponse.exception!);
    }

    return Right(body);
  }

  Future<Either<ServerException, Map<String, dynamic>>> executeGet(
      String action) async {
    var url = Uri.parse('192.168.0.1:8080/$action');
    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    final body = json.decode(response.body);
    final baseResponse = ResponseDto.fromJson(body);

    if (!baseResponse.success) {
      return Left(baseResponse.exception!);
    }

    return Right(body);
  }
}
