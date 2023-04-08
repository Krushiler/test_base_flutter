import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_base_flutter/features/home/dictionary/terms/bloc/terms_event.dart';
import 'package:test_base_flutter/features/home/dictionary/terms/bloc/terms_state.dart';
import 'package:test_base_flutter/repository/interfaces/dictonary_repository.dart';

class TermsBloc extends Bloc<TermsEvent, TermsState> {
  final DictionaryRepository dictionaryRepository;

  TermsBloc(
    this.dictionaryRepository,
  ) : super(ProgressTermsState(true)) {
    on<LoadTermsEvent>((event, emit) async {
      emit.call(ProgressTermsState(true));

      final termsResult =
          await dictionaryRepository.getTerms(event.dictionaryId);

      emit.call(termsResult.fold(
        (l) => FailureTermsState(l.message),
        (r) => LoadedTermsState(r.terms, refresh: event.refresh),
      ));
      emit.call(ProgressTermsState(false));
    });
  }
}
