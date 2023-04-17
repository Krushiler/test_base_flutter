import 'package:test_base_flutter/data/model/dictionary/tag.dart';

abstract class HomeRootState {}

class ProgressHomeRootState extends HomeRootState {
  final bool progress;

  ProgressHomeRootState(this.progress);
}

class LoadedHomeRootState extends HomeRootState {
  final List<Tag> tags;
  final Tag selectedTag;

  LoadedHomeRootState(this.tags, this.selectedTag);
}

class NewTagSelectedHomeRootState extends HomeRootState {
  final Tag selectedTag;

  NewTagSelectedHomeRootState(this.selectedTag);
}

class EnabledTagEditHomeRootState extends HomeRootState {
  final bool enabled;

  EnabledTagEditHomeRootState(this.enabled);
}

class FailureHomeRootState extends HomeRootState {
  final String message;

  FailureHomeRootState(this.message);
}
