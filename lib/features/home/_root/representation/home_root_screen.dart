import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_base_flutter/features/home/_root/bloc/home_root_bloc.dart';
import 'package:test_base_flutter/features/home/_root/bloc/home_root_state.dart';
import 'package:test_base_flutter/features/home/home_routing.dart';
import 'package:test_base_flutter/ui/components/screen.dart';
import 'package:test_base_flutter/ui/kit/icons.dart';
import 'package:test_base_flutter/util/snackbar_util.dart';

final GlobalKey<ScaffoldState> homeRootScaffoldKey = GlobalKey();

class HomeRootScreenProvider extends StatelessWidget {
  final Widget child;
  final String currentLocation;

  const HomeRootScreenProvider({
    super.key,
    required this.child,
    required this.currentLocation,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeRootBloc>(
      create: (context) => HomeRootBloc(),
      child: HomeRootScreen(
        currentLocation: currentLocation,
        child: child,
      ),
    );
  }
}

class HomeRootScreen extends StatefulWidget {
  final Widget child;
  final String currentLocation;

  const HomeRootScreen({
    Key? key,
    required this.child,
    required this.currentLocation,
  }) : super(key: key);

  @override
  State<HomeRootScreen> createState() => _HomeRootScreenState();
}

class _HomeRootScreenState extends State<HomeRootScreen> {
  bool inProgress = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    return ScreenConsumer<HomeRootBloc, HomeRootState>(
      scaffoldKey: homeRootScaffoldKey,
      padding: EdgeInsets.zero,
      listener: (context, state) {
        if (state is LoadedHomeRootState) {}
        if (state is ProgressHomeRootState) {
          setState(() {
            inProgress = state.progress;
          });
        }
        if (state is FailureHomeRootState) {
          context.showSnackBar(state.message);
          setState(() {
            error = state.message;
          });
        }
      },
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getPageIndex,
        onTap: (index) {
          context.goNamed(_getIndexLocation(index));
        },
        items: [
          BottomNavigationBarItem(
            icon: TestBaseIcons.practice,
            label: 'Practice',
          ),
          BottomNavigationBarItem(
            icon: TestBaseIcons.dictionary,
            label: 'Dictionary',
          ),
        ],
      ),
      builder: (context, state) => widget.child,
      showProgress: (state) => inProgress,
    );
  }

  int get _getPageIndex {
    switch (widget.currentLocation) {
      case HomeRoute.practice:
        return 0;
      case HomeRoute.dictionaries:
        return 1;
      default:
        return 0;
    }
  }

  String _getIndexLocation(int index) {
    switch (index) {
      case 0:
        return HomeRoute.practice;
      case 1:
        return HomeRoute.dictionaries;
      default:
        return HomeRoute.practice;
    }
  }
}
