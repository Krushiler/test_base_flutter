import 'package:test_base_flutter/data/model/game/question_term.dart';

class Question {
  List<QuestionTerm> terms;
  QuestionTerm rightTerm;

  Question(this.terms, this.rightTerm);
}
