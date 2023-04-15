import 'package:dartz/dartz.dart';
import 'package:test_base_flutter/data/dto/dictionary/dictionary_list_dto.dart';
import 'package:test_base_flutter/data/dto/dictionary/terms_dto.dart';
import 'package:test_base_flutter/data/dto/dictionary/terms_search_dto.dart';
import 'package:test_base_flutter/data/model/_exception/user_exception.dart';

abstract class DictionaryRepository {
  Future<Either<UserException, DictionaryListDto>> getDictionaries();

  Future<Either<UserException, TermsDto>> getTerms(int dictionaryId);

  Future<Either<UserException, TermsSearchDto>> searchTerms(int dictionaryId, String query);
}
