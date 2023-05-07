import 'package:dartz/dartz.dart';
import 'package:test_base_flutter/data/dto/dictionary/dictionary_list_response.dart';
import 'package:test_base_flutter/data/dto/terms/term_list_response.dart';
import 'package:test_base_flutter/data/model/_exception/user_exception.dart';
import 'package:test_base_flutter/data/model/dictionary/dictionary_list_result.dart';
import 'package:test_base_flutter/data/model/dictionary/tag.dart';
import 'package:test_base_flutter/data/model/terms/term.dart';
import 'package:test_base_flutter/data/model/terms/term_list_result.dart';
import 'package:test_base_flutter/data/model/terms/terms_search_result.dart';
import 'package:test_base_flutter/repository/interfaces/dictonary_repository.dart';
import 'package:test_base_flutter/repository/remote/remote_repository.dart';

class RemoteDictionaryRepository extends RemoteRepository
    implements DictionaryRepository {
  final List<Term> _cachedWords = [];

  @override
  Future<Either<UserException, DictionaryListResult>> getDictionaries(
      String tag) async {
    final json = await executeGet('Set/${RemoteRepository.token}');
    return json.fold(
      (l) => Left(l),
      (r) => Right(
        DictionaryListResponse.fromJson(r).model,
      ),
    );
  }

  @override
  Future<Either<UserException, List<Tag>>> getTags() async {
    return const Right(<Tag>[]);
  }

  @override
  Future<Either<UserException, TermListResult>> getTerms(
      int dictionaryId) async {
    _cachedWords.clear();
    final json =
        await executeGet('Set/${RemoteRepository.token}/$dictionaryId');

    return json.fold(
      (l) => Left(l),
      (r) {
        final model = TermListResponse.fromJson(r).model;
        _cachedWords.addAll(model.terms);
        return Right(
          model,
        );
      },
    );
  }

  @override
  Future<Either<UserException, TermsSearchResult>> searchTerms(
      int dictionaryId, String query) async {
    final List<Term> terms = [];
    for (final element in _cachedWords) {
      if (element.name
          .trim()
          .toLowerCase()
          .startsWith(query.trim().toLowerCase())) {
        terms.add(element);
      }
    }
    for (final element in _cachedWords) {
      if (element.translation
              .trim()
              .toLowerCase()
              .contains(query.trim().toLowerCase()) &&
          !terms.contains(element)) {
        terms.add(element);
      }
    }
    for (final element in _cachedWords) {
      if (element.description
              .trim()
              .toLowerCase()
              .contains(query.trim().toLowerCase()) &&
          !terms.contains(element)) {
        terms.add(element);
      }
    }
    return Right(TermsSearchResult(terms));
  }
}
