abstract class TermsEvent {}

class LoadTermsEvent extends TermsEvent {
  final int dictionaryId;
  final bool refresh;

  LoadTermsEvent(this.dictionaryId, {this.refresh = false});
}
