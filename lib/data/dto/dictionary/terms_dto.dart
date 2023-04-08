import 'package:test_base_flutter/data/model/dictionary/term.dart';

class TermsDto {
  final String dictionaryName;
  final List<Term> terms;

  TermsDto(this.dictionaryName, this.terms);
}
