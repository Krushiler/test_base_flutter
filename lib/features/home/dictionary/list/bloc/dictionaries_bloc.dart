import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_base_flutter/features/home/dictionary/list/bloc/dictionaries_event.dart';
import 'package:test_base_flutter/features/home/dictionary/list/bloc/dictionaries_state.dart';
import 'package:test_base_flutter/repository/interfaces/dictonary_repository.dart';

class DictionariesBloc extends Bloc<DictionariesEvent, DictionariesState> {
  final DictionaryRepository dictionaryRepository;

  DictionariesBloc(
    this.dictionaryRepository,
  ) : super(ProgressDictionariesState(true)) {
    on<LoadDictionariesEvent>((event, emit) async {
      emit.call(ProgressDictionariesState(true));
      final dictionariesResult = await dictionaryRepository.getDictionaries();
      emit.call(
        dictionariesResult.fold(
          (l) => FailureDictionariesState(l.message),
          (r) => LoadedDictionariesState(r, event.refresh),
        ),
      );
      emit.call(ProgressDictionariesState(false));
    });
  }
}
