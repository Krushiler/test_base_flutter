import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_base_flutter/features/game/prepare/bloc/prepare_game_event.dart';
import 'package:test_base_flutter/features/game/prepare/bloc/prepare_game_state.dart';
import 'package:test_base_flutter/repository/interfaces/dictonary_repository.dart';

class PrepareGameBloc extends Bloc<PrepareGameEvent, PrepareGameState> {
  final DictionaryRepository dictionaryRepository;

  PrepareGameBloc(this.dictionaryRepository)
      : super(ProgressPrepareGameState(true)) {
    on<LoadPrepareGameEvent>((event, emit) async {
      emit.call(ProgressPrepareGameState(true));

      final dictionariesResult = await dictionaryRepository.getDictionaries();

      emit.call(dictionariesResult.fold(
        (l) => FailurePrepareGameState(l.message),
        (r) => LoadedPrepareGameState(r.dictionaries),
      ));

      emit.call(ProgressPrepareGameState(false));
    });
  }
}
