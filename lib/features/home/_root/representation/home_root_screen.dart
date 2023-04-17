import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_base_flutter/data/model/dictionary/tag.dart';
import 'package:test_base_flutter/features/home/_root/bloc/home_root_bloc.dart';
import 'package:test_base_flutter/features/home/_root/bloc/home_root_event.dart';
import 'package:test_base_flutter/features/home/_root/bloc/home_root_state.dart';
import 'package:test_base_flutter/features/home/_root/representation/components/tag_switcher.dart';
import 'package:test_base_flutter/features/home/home_routing.dart';
import 'package:test_base_flutter/ui/components/screen.dart';
import 'package:test_base_flutter/ui/kit/icons.dart';
import 'package:test_base_flutter/ui/kit/test_base_app_bar.dart';
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
      create: (context) => HomeRootBloc(context.read())..add(LoadHomeRootEvent()),
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

  List<Tag> tags = [];
  Tag? selectedTag;
  bool tagEditingEnabled = false;

  @override
  Widget build(BuildContext context) {
    return ScreenConsumer<HomeRootBloc, HomeRootState>(
      scaffoldKey: homeRootScaffoldKey,
      padding: EdgeInsets.zero,
      listener: (context, state) {
        setState(() {
          if (state is LoadedHomeRootState) {
            tags.clear();
            tags.addAll(state.tags);
            selectedTag = state.selectedTag;
          }
          if (state is ProgressHomeRootState) {
            inProgress = state.progress;
          }
          if (state is NewTagSelectedHomeRootState) {
            selectedTag = state.selectedTag;
          }
          if (state is EnabledTagEditHomeRootState) {
            tagEditingEnabled = state.enabled;
          }
          if (state is FailureHomeRootState) {
            context.showSnackBar(state.message);
          }
        });
      },
      appBar: TestBaseAppBar(
        title: const Text('TestBase'),
        actions: [
          if (selectedTag != null)
            TagSwitcher(
              value: selectedTag!,
              onTagSwitched: (tag) {
                BlocProvider.of<HomeRootBloc>(context).add(
                  SelectTagHomeRootEvent(
                    tag,
                  ),
                );
              },
              values: tags,
            )
        ],
      ),
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
