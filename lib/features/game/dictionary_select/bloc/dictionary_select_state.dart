import 'package:test_base_flutter/data/dto/dictionary/dictionary_list_dto.dart';

abstract class DictionarySelectState {}

class ProgressDictionariesState extends DictionarySelectState {
  final bool progress;

  ProgressDictionariesState(this.progress);
}

class LoadedDictionariesState extends DictionarySelectState {
  final DictionaryListDto dictionaryList;
  final bool refresh;

  LoadedDictionariesState(this.dictionaryList, this.refresh);
}

class FailureDictionariesState extends DictionarySelectState {
  final String message;

  FailureDictionariesState(this.message);
}
