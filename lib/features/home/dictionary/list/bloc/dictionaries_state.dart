import 'package:test_base_flutter/data/model/dictionary/dictionary_list_result.dart';

abstract class DictionariesState {}

class ProgressDictionariesState extends DictionariesState {
  final bool progress;

  ProgressDictionariesState(this.progress);
}

class LoadedDictionariesState extends DictionariesState {
  final DictionaryListResult dictionaryList;
  final bool refresh;

  LoadedDictionariesState(this.dictionaryList, this.refresh);
}

class FailureDictionariesState extends DictionariesState {
  final String message;

  FailureDictionariesState(this.message);
}
