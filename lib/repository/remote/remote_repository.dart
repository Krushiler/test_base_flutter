import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:test_base_flutter/data/dto/_base/response_dto.dart';
import 'package:test_base_flutter/data/model/_exception/server_exception.dart';

abstract class RemoteRepository {
  static const token = '9mYfLCoyL9RjD6pop6Ov';
  static const baseUrl = 'http://62.84.121.82:8080/api';
  static const defaultTimeout = Duration(seconds: 10);

  Future<Either<ServerException, Map<String, dynamic>>> executePost(
      String action, Map<String, dynamic> payload) async {
    var url = Uri.parse('$baseUrl/$action');
    try {
      final response = await http
          .post(
            url,
            headers: {"Content-Type": "application/json"},
            body: json.encode(payload),
          )
          .timeout(defaultTimeout);

      final body = json.decode(response.body);
      final baseResponse = ResponseDto.fromJson(body);

      if (!baseResponse.success) {
        return Left(baseResponse.exception!);
      }

      return Right(body);
    } on TimeoutException catch (_) {
      return Left(ServerException('Server is unavailable'));
    } on SocketException catch (_) {
      return Left(ServerException('Something went wrong'));
    } on FormatException catch (_) {
      return Left(ServerException('Internal server error'));
    } on HandshakeException catch (_) {
      return Left(ServerException('Wrong server ip/port'));
    }
  }

  Future<Either<ServerException, Map<String, dynamic>>> executeGet(
      String action) async {
    var url = Uri.parse('$baseUrl/$action');

    try {
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      ).timeout(defaultTimeout);

      final body = json.decode(response.body);
      final baseResponse = ResponseDto.fromJson(body);

      if (!baseResponse.success) {
        return Left(baseResponse.exception!);
      }

      return Right(body);
    } on TimeoutException catch (_) {
      return Left(ServerException('Server is unavailable'));
    } on SocketException catch (_) {
      return Left(ServerException('Something went wrong'));
    } on FormatException catch (_) {
      return Left(ServerException('Internal server error'));
    } on HandshakeException catch (_) {
      return Left(ServerException('Wrong server ip/port'));
    }
  }
}
