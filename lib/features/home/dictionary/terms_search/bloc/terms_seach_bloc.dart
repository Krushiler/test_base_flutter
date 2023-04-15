import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_base_flutter/features/home/dictionary/terms_search/bloc/terms_search_event.dart';
import 'package:test_base_flutter/features/home/dictionary/terms_search/bloc/terms_search_state.dart';
import 'package:test_base_flutter/repository/interfaces/dictonary_repository.dart';

class TermsSearchBloc extends Bloc<TermsSearchEvent, TermsSearchState> {
  final DictionaryRepository dictionaryRepository;

  TermsSearchBloc(
    this.dictionaryRepository,
  ) : super(ProgressTermsSearchState(false)) {
    on<SearchTermsSearchEvent>((event, emit) async {
      if (event.query.trim().isEmpty) {
        emit.call(ProgressTermsSearchState(false));
        return;
      }

      emit.call(ProgressTermsSearchState(true));

      final termsResult = await dictionaryRepository.searchTerms(
          event.dictionaryId, event.query);

      emit.call(termsResult.fold(
        (l) => FailureTermsSearchState(l.message),
        (r) => LoadedTermsSearchState(r.terms),
      ));

      emit.call(ProgressTermsSearchState(false));
    });
  }
}
