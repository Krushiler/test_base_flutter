import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_base_flutter/features/home/_root/representation/home_root_screen.dart';
import 'package:test_base_flutter/features/home/dictionary/list/representation/dictionaries_screen.dart';
import 'package:test_base_flutter/features/home/dictionary/terms/representation/terms_screen.dart';
import 'package:test_base_flutter/ui/navigation/router.dart';
import 'package:test_base_flutter/util/navigation_util.dart';

final _homeNavigator = GlobalKey<NavigatorState>();

class HomeRoute {
  static const practice = '/practice';
  static const dictionaries = '/dictionaries';
  static const terms = '/terms';
}

class HomeParams {
  static const dictionaryId = 'dictionaryId';
}

final homeRoutes = [
  ShellRoute(
      navigatorKey: _homeNavigator,
      builder: (context, state, child) => HomeRootScreenProvider(
            currentLocation: state.location,
            child: child,
          ),
      routes: [
        GoRoute(
          path: HomeRoute.practice,
          name: HomeRoute.practice,
          parentNavigatorKey: _homeNavigator,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: Scaffold(
              body: Center(
                child: Text('Practice'),
              ),
            ),
          ),
        ),
        GoRoute(
          path: HomeRoute.dictionaries,
          name: HomeRoute.dictionaries,
          parentNavigatorKey: _homeNavigator,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: DictionariesScreenProvider(),
          ),
        ),
      ]),
  GoRoute(
    path: HomeRoute.terms,
    name: HomeRoute.terms,
    parentNavigatorKey: rootNavigator,
    builder: (context, state) => TermsScreenProvider(
      dictionaryId: state.getIntQueryParam(HomeParams.dictionaryId) ?? 0,
    ),
  ),
];
