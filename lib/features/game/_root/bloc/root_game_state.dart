import 'package:test_base_flutter/data/model/game/question.dart';
import 'package:test_base_flutter/data/model/game/question_term.dart';

abstract class RootGameState {}

class ProgressRootGameState extends RootGameState {
  final bool progress;

  ProgressRootGameState(this.progress);
}

class CountDownRootGameState extends RootGameState {
  int time;

  CountDownRootGameState(this.time);
}

class NewQuestionRootGameState extends RootGameState {
  final Question question;
  int currentQuestion;
  int questionCount;

  NewQuestionRootGameState(
    this.question, {
    required this.currentQuestion,
    required this.questionCount,
  });
}

class MistakeRootGameState extends RootGameState {
  QuestionTerm term;

  MistakeRootGameState(this.term);
}

class EndedRootGameState extends RootGameState {
  final int mistakes;
  final double takenTime;

  EndedRootGameState({
    required this.mistakes,
    required this.takenTime,
  });
}
