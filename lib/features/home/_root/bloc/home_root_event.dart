import 'package:test_base_flutter/data/model/dictionary/tag.dart';

abstract class HomeRootEvent {}

class LoadHomeRootEvent extends HomeRootEvent {}

class SelectTagHomeRootEvent extends HomeRootEvent {
  final Tag tag;

  SelectTagHomeRootEvent(this.tag);
}