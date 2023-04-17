import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:test_base_flutter/data/dto/dictionary/dictionary_list_dto.dart';
import 'package:test_base_flutter/data/dto/dictionary/terms_dto.dart';
import 'package:test_base_flutter/data/dto/dictionary/terms_search_dto.dart';
import 'package:test_base_flutter/data/dto/json.dart';
import 'package:test_base_flutter/data/model/_exception/user_exception.dart';
import 'package:test_base_flutter/data/model/dictionary/dictionary.dart';
import 'package:test_base_flutter/data/model/dictionary/tag.dart';
import 'package:test_base_flutter/data/model/dictionary/term.dart';
import 'package:test_base_flutter/repository/interfaces/dictonary_repository.dart';

class LocalDictionaryRepository implements DictionaryRepository {
  @override
  Future<Either<UserException, DictionaryListDto>> getDictionaries(
      String tag) async {
    final List<_DictionaryInfo> dicts;
    try {
      dicts = await _getAvailableDictionaries();
    } catch (e) {
      return Left(UserException('Unable to get available dictionaries'));
    }
    final list = dicts
        .map((e) => Dictionary(
              id: e.id,
              name: e.name,
              tag: e.tag,
            ))
        .where((element) => element.tag == tag)
        .toList();
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
          name: termsJson[i],
          description: termsJson[i + 1],
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

  @override
  Future<Either<UserException, TermsSearchDto>> searchTerms(
      int dictionaryId, String query) async {
    final termsResult = await getTerms(dictionaryId);
    final List<Term> terms = [];

    return termsResult.fold(
      (l) async {
        return Left(l);
      },
      (r) async {
        for (final element in r.terms) {
          if (element.name
              .trim()
              .toLowerCase()
              .startsWith(query.trim().toLowerCase())) {
            terms.add(element);
          }
        }
        for (final element in r.terms) {
          if (element.name
                  .trim()
                  .toLowerCase()
                  .contains(query.trim().toLowerCase()) &&
              !terms.contains(element)) {
            terms.add(element);
          }
        }
        for (final element in r.terms) {
          if (element.description
                  .trim()
                  .toLowerCase()
                  .contains(query.trim().toLowerCase()) &&
              !terms.contains(element)) {
            terms.add(element);
          }
        }
        return Right(TermsSearchDto(terms));
      },
    );
  }

  @override
  Future<Either<UserException, List<Tag>>> getTags() async =>
      Right([Tag('EN', 'en'), Tag('RU', 'ru')]);

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
              tag: dict['tag']),
        );
      } on FormatException catch (_) {}
    }
    return result;
  }
}

class _DictionaryInfo {
  final int id;
  final String name;
  final String tag;
  final String json;

  _DictionaryInfo({
    required this.id,
    required this.name,
    required this.tag,
    required this.json,
  });
}
