import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_base_flutter/features/home/_root/bloc/home_root_event.dart';
import 'package:test_base_flutter/features/home/_root/bloc/home_root_state.dart';

class HomeRootBloc extends Bloc<HomeRootEvent, HomeRootState> {

  HomeRootBloc() : super(ProgressHomeRootState(true)) {
    on<LoadHomeRootEvent>((event, emit) async {
      emit.call(ProgressHomeRootState(false));
    });
  }
}
