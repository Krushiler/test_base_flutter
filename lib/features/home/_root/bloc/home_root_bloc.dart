import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_base_flutter/data/store/settings_store.dart';
import 'package:test_base_flutter/features/home/_root/bloc/home_root_event.dart';
import 'package:test_base_flutter/features/home/_root/bloc/home_root_state.dart';
import 'package:test_base_flutter/repository/interfaces/dictonary_repository.dart';

class HomeRootBloc extends Bloc<HomeRootEvent, HomeRootState> {
  final DictionaryRepository dictionaryRepository;

  HomeRootBloc(
    this.dictionaryRepository,
  ) : super(ProgressHomeRootState(true)) {
    on<LoadHomeRootEvent>((event, emit) async {
      emit.call(ProgressHomeRootState(true));
      final tagsResult = await dictionaryRepository.getTags();
      final selectedTagValue = await SettingsStore.instance.dictionaryTag;
      emit.call(
        tagsResult.fold(
          (l) => FailureHomeRootState(l.message),
          (r) {
            final selectedTag = r.firstWhere(
              (element) => element.value == selectedTagValue,
            );
            return LoadedHomeRootState(r, selectedTag);
          },
        ),
      );
      emit.call(EnabledTagEditHomeRootState(true));
      emit.call(ProgressHomeRootState(false));
    });

    on<SelectTagHomeRootEvent>((event, emit) async {
      emit.call(EnabledTagEditHomeRootState(false));
      await SettingsStore.instance.setDictionaryTag(event.tag.value);
      emit.call(NewTagSelectedHomeRootState(event.tag));
      emit.call(EnabledTagEditHomeRootState(true));
    });
  }
}
