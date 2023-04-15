import 'package:test_base_flutter/data/model/dictionary/term.dart';
import 'package:test_base_flutter/data/model/game/game_state.dart';

abstract class RootGameEvent {}

class GameStateChangedRootGameEvent extends RootGameEvent {
  GameState gameState;

  GameStateChangedRootGameEvent(this.gameState);
}

class StartRootGameEvent extends RootGameEvent {
  final int questionsCount;
  final int dictionaryId;

  StartRootGameEvent({
    required this.questionsCount,
    required this.dictionaryId,
  });
}

class AnswerQuestionRootGameEvent extends RootGameEvent {
  final Term term;

  AnswerQuestionRootGameEvent(this.term);
}
