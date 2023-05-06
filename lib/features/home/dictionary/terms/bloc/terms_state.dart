import 'package:test_base_flutter/data/model/terms/term.dart';

abstract class TermsState {}

class LoadedTermsState extends TermsState {
  final List<Term> terms;
  final bool refresh;
  final String dictionaryName;

  LoadedTermsState(this.terms, this.dictionaryName, {this.refresh = false});
}

class ProgressTermsState extends TermsState {
  final bool progress;

  ProgressTermsState(this.progress);
}

class FailureTermsState extends TermsState {
  final String message;

  FailureTermsState(this.message);
}
