import 'package:dartz/dartz.dart';
import 'package:test_base_flutter/data/model/_exception/user_exception.dart';
import 'package:test_base_flutter/data/model/dictionary/term.dart';
import 'package:test_base_flutter/data/model/game/game_state.dart';
import 'package:test_base_flutter/repository/interfaces/dictonary_repository.dart';

typedef VoidResult = Future<Either<UserException, void>>;

abstract class GameRepository {
  Stream<GameState> get gameState;

  VoidResult startGame({
    required int questionsCount,
    required int dictionaryId,
    required DictionaryRepository dictionaryRepository,
  });

  VoidResult giveAnswer(Term term);
}
