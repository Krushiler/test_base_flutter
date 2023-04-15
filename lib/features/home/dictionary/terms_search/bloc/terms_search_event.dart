abstract class TermsSearchEvent {}

class SearchTermsSearchEvent extends TermsSearchEvent {
  final int dictionaryId;
  final String query;

  SearchTermsSearchEvent(this.dictionaryId, this.query);
}
