import 'package:test_base_flutter/data/model/dictionary/dictionary.dart';

abstract class PrepareGameState {}

class ProgressPrepareGameState extends PrepareGameState {
  final bool progress;

  ProgressPrepareGameState(this.progress);
}

class FailurePrepareGameState extends PrepareGameState {
  final String message;

  FailurePrepareGameState(this.message);
}

class LoadedPrepareGameState extends PrepareGameState {
  List<Dictionary> dictionaries;

  LoadedPrepareGameState(this.dictionaries);
}
