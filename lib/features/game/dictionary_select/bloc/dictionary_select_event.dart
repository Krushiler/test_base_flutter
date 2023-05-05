abstract class DictionarySelectEvent {}

class LoadDictionarySelectEvent extends DictionarySelectEvent {
  final bool refresh;

  LoadDictionarySelectEvent({this.refresh = false});
}
