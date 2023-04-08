import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:test_base_flutter/data/dto/dictionary/dictionary_list_dto.dart';
import 'package:test_base_flutter/data/dto/dictionary/terms_dto.dart';
import 'package:test_base_flutter/data/dto/json.dart';
import 'package:test_base_flutter/data/model/_exception/user_exception.dart';
import 'package:test_base_flutter/data/model/dictionary/dictionary.dart';
import 'package:test_base_flutter/data/model/dictionary/term.dart';
import 'package:test_base_flutter/repository/interfaces/dictonary_repository.dart';

class LocalDictionaryRepository implements DictionaryRepository {
  @override
  Future<Either<UserException, DictionaryListDto>> getDictionaries() async {
    final List<_DictionaryInfo> dicts;
    try {
      dicts = await _getAvailableDictionaries();
    } catch (e) {
      return Left(UserException('Unable to get available dictionaries'));
    }
    final list = dicts.map((e) => Dictionary(id: e.id, name: e.name)).toList();
    return Right(DictionaryListDto(list));
  }

  @override
  Future<Either<UserException, TermsDto>> getTerms(int dictionaryId) async {
    final List<_DictionaryInfo> dicts;
    try {
      dicts = await _getAvailableDictionaries();
    } catch (e) {
      return Left(UserException('Unable to get available dictionaries'));
    }
    final neededDict =
        dicts.where((element) => element.id == dictionaryId).first;

    final neededDictJson = await _jsonFromAssets(
      'assets/dictionaries/${neededDict.json}',
    );

    final List<Term> terms = [];

    final termsJson = neededDictJson['terms'];

    for (int i = 0; i < termsJson.length; i += 2) {
      terms.add(
        Term(
          name: termsJson['terms'][i],
          description: termsJson['terms'][i + 1],
        ),
      );
    }

    return Right(
      TermsDto(
        neededDict.name,
        terms,
      ),
    );
  }

  Future<Json> _jsonFromAssets(String fileName) async {
    return jsonDecode(await rootBundle.loadString(fileName));
  }

  Future<List<_DictionaryInfo>> _getAvailableDictionaries() async {
    final List<_DictionaryInfo> result = [];

    final json = await _jsonFromAssets('assets/dictionaries/_dicts.json');
    for (final dict in json['dictionaries']) {
      try {
        final dictJson = await _jsonFromAssets(
          'assets/dictionaries/${dict['file']}',
        );
        result.add(
          _DictionaryInfo(
            id: dict['id'],
            name: dictJson['name'],
            json: dict['file'],
          ),
        );
      } on FormatException catch (_) {}
    }
    return result;
  }
}

class _DictionaryInfo {
  final int id;
  final String name;
  final String json;

  _DictionaryInfo({
    required this.id,
    required this.name,
    required this.json,
  });
}
