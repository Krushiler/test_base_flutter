import 'package:test_base_flutter/data/model/game/game_state.dart';
import 'package:test_base_flutter/data/model/game/game_type.dart';
import 'package:test_base_flutter/data/model/game/question_term.dart';

abstract class RootGameEvent {}

class GameStateChangedRootGameEvent extends RootGameEvent {
  GameState gameState;

  GameStateChangedRootGameEvent(this.gameState);
}

class StartRootGameEvent extends RootGameEvent {
  final int questionsCount;
  final int dictionaryId;
  final GameType gameType;

  StartRootGameEvent({
    required this.questionsCount,
    required this.dictionaryId,
    required this.gameType
  });
}

class AnswerQuestionRootGameEvent extends RootGameEvent {
  final QuestionTerm term;

  AnswerQuestionRootGameEvent(this.term);
}
