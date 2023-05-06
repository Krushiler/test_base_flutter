import 'package:dartz/dartz.dart';
import 'package:test_base_flutter/data/model/game/game_state.dart';
import 'package:test_base_flutter/data/model/game/game_type.dart';
import 'package:test_base_flutter/data/model/game/practice_game_logic.dart';
import 'package:test_base_flutter/data/model/game/question_term.dart';
import 'package:test_base_flutter/repository/interfaces/dictonary_repository.dart';
import 'package:test_base_flutter/repository/interfaces/game_repository.dart';

class PracticeGameRepository implements GameRepository {
  final PracticeGameLogic logic = PracticeGameLogic();

  @override
  Stream<GameState> get gameState => logic.state;

  @override
  VoidResult giveAnswer(QuestionTerm term) async {
    logic.giveAnswer(term);
    return const Right(null);
  }

  @override
  VoidResult startGame({
    required int questionsCount,
    required int dictionaryId,
    required DictionaryRepository dictionaryRepository,
    required GameType gameType
  }) async {
    logic.setup(
      questionsCount: questionsCount,
      dictionaryId: dictionaryId,
      dictionaryRepository: dictionaryRepository,
      gameType: gameType
    );
    logic.startGame();
    return const Right(null);
  }
}
