import 'package:test_base_flutter/data/model/dictionary/term.dart';

abstract class TermsState {}

class LoadedTermsState extends TermsState {
  final List<Term> terms;
  final bool refresh;

  LoadedTermsState(this.terms, {this.refresh = false});
}

class ProgressTermsState extends TermsState {
  final bool progress;

  ProgressTermsState(this.progress);
}

class FailureTermsState extends TermsState {
  final String message;

  FailureTermsState(this.message);
}
