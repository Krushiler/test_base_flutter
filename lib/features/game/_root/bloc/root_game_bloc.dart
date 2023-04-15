import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_base_flutter/data/model/game/game_state.dart';
import 'package:test_base_flutter/features/game/_root/bloc/root_game_event.dart';
import 'package:test_base_flutter/features/game/_root/bloc/root_game_state.dart';
import 'package:test_base_flutter/repository/interfaces/dictonary_repository.dart';
import 'package:test_base_flutter/repository/interfaces/game_repository.dart';

class RootGameBloc extends Bloc<RootGameEvent, RootGameState> {
  final DictionaryRepository dictionaryRepository;
  final GameRepository gameRepository;

  RootGameBloc(
    this.dictionaryRepository,
    this.gameRepository,
  ) : super(ProgressRootGameState(true)) {
    on<GameStateChangedRootGameEvent>((event, emit) {
      emit.call(ProgressRootGameState(false));
      final gameState = event.gameState;
      if (gameState is CountDownGameState) {
        emit.call(CountDownRootGameState(gameState.number));
      }
      if (gameState is NewQuestionGameState) {
        emit.call(NewQuestionRootGameState(gameState.question));
      }
      if (gameState is MistakeGameState) {
        emit.call(MistakeRootGameState(gameState.mistakenTerm));
      }
      if (gameState is EndedGameState) {
        emit.call(EndedRootGameState(
          mistakes: gameState.mistakes,
          takenTime: gameState.time,
        ));
      }
    });
    on<StartRootGameEvent>((event, emit) {
      gameRepository.startGame(
        questionsCount: event.questionsCount,
        dictionaryId: event.dictionaryId,
        dictionaryRepository: dictionaryRepository,
      );
    });
    on<AnswerQuestionRootGameEvent>((event, emit) {
      gameRepository.giveAnswer(event.term);
    });

    gameRepository.gameState.listen((event) {
      add(GameStateChangedRootGameEvent(event));
    });
  }
}
