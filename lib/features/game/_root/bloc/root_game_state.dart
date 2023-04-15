import 'package:test_base_flutter/data/model/dictionary/term.dart';
import 'package:test_base_flutter/data/model/game/question.dart';

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

  NewQuestionRootGameState(this.question);
}

class MistakeRootGameState extends RootGameState {
  Term term;

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
