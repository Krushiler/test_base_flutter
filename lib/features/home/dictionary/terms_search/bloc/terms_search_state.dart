import 'package:test_base_flutter/data/model/terms/term.dart';

abstract class TermsSearchState {}

class LoadedTermsSearchState extends TermsSearchState {
  final List<Term> terms;

  LoadedTermsSearchState(this.terms);
}

class ProgressTermsSearchState extends TermsSearchState {
  final bool progress;

  ProgressTermsSearchState(this.progress);
}

class FailureTermsSearchState extends TermsSearchState {
  final String message;

  FailureTermsSearchState(this.message);
}
