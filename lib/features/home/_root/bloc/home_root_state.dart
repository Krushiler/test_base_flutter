abstract class HomeRootState {}

class ProgressHomeRootState extends HomeRootState {
  final bool progress;

  ProgressHomeRootState(this.progress);
}

class LoadedHomeRootState extends HomeRootState {
  LoadedHomeRootState();
}

class FailureHomeRootState extends HomeRootState {
  final String message;

  FailureHomeRootState(this.message);
}
