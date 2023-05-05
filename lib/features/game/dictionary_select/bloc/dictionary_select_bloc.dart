import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_base_flutter/data/store/settings_store.dart';
import 'package:test_base_flutter/features/game/dictionary_select/bloc/dictionary_select_event.dart';
import 'package:test_base_flutter/features/game/dictionary_select/bloc/dictionary_select_state.dart';
import 'package:test_base_flutter/repository/interfaces/dictonary_repository.dart';

class DictionarySelectBloc extends Bloc<DictionarySelectEvent, DictionarySelectState> {
  final DictionaryRepository dictionaryRepository;

  listenSettings() {
    add(LoadDictionarySelectEvent(refresh: true));
  }

  DictionarySelectBloc(
      this.dictionaryRepository,
      ) : super(ProgressDictionariesState(true)) {
    on<LoadDictionarySelectEvent>((event, emit) async {
      emit.call(ProgressDictionariesState(true));
      final dictionariesResult = await dictionaryRepository
          .getDictionaries(await SettingsStore.instance.dictionaryTag);
      emit.call(
        dictionariesResult.fold(
              (l) => FailureDictionariesState(l.message),
              (r) => LoadedDictionariesState(r, event.refresh),
        ),
      );
      emit.call(ProgressDictionariesState(false));
    });

    SettingsStore.instance.addListener(listenSettings);
  }

  @override
  Future<void> close() {
    SettingsStore.instance.removeListener(listenSettings);
    return super.close();
  }
}
