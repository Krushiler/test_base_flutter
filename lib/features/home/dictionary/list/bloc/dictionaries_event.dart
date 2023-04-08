abstract class DictionariesEvent {}

class LoadDictionariesEvent extends DictionariesEvent {
  final bool refresh;

  LoadDictionariesEvent({this.refresh = false});
}
