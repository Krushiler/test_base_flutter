import 'package:test_base_flutter/data/model/game/question.dart';
import 'package:test_base_flutter/data/model/game/question_term.dart';

abstract class GameState {}

class CountDownGameState extends GameState {
  int number;

  CountDownGameState(this.number);
}

class NewQuestionGameState extends GameState {
  Question question;

  NewQuestionGameState(this.question);
}

class MistakeGameState extends GameState {
  QuestionTerm mistakenTerm;

  MistakeGameState(this.mistakenTerm);
}

class EndedGameState extends GameState {
  final int mistakes;
  final double time;

  EndedGameState({required this.mistakes, required this.time});
}
