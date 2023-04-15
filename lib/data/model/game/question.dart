import 'package:test_base_flutter/data/model/dictionary/term.dart';

class Question {
  List<Term> terms;
  Term rightTerm;

  Question(this.terms, this.rightTerm);
}
