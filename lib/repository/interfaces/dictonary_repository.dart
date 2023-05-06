import 'package:dartz/dartz.dart';
import 'package:test_base_flutter/data/model/dictionary/dictionary_list_result.dart';
import 'package:test_base_flutter/data/model/terms/term_list_result.dart';
import 'package:test_base_flutter/data/model/terms/terms_search_result.dart';
import 'package:test_base_flutter/data/model/_exception/user_exception.dart';
import 'package:test_base_flutter/data/model/dictionary/tag.dart';

abstract class DictionaryRepository {
  Future<Either<UserException, DictionaryListResult>> getDictionaries(String tag);

  Future<Either<UserException, TermListResult>> getTerms(int dictionaryId);

  Future<Either<UserException, TermsSearchResult>> searchTerms(int dictionaryId, String query);

  Future<Either<UserException, List<Tag>>> getTags();
}
