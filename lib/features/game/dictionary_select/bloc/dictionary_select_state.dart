import 'package:test_base_flutter/data/model/dictionary/dictionary_list_result.dart';

abstract class DictionarySelectState {}

class ProgressDictionariesState extends DictionarySelectState {
  final bool progress;

  ProgressDictionariesState(this.progress);
}

class LoadedDictionariesState extends DictionarySelectState {
  final DictionaryListResult dictionaryList;
  final bool refresh;

  LoadedDictionariesState(this.dictionaryList, this.refresh);
}

class FailureDictionariesState extends DictionarySelectState {
  final String message;

  FailureDictionariesState(this.message);
}
