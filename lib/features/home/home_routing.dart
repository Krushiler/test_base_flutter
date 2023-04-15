import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_base_flutter/features/game/_root/representation/root_game_screen.dart';
import 'package:test_base_flutter/features/game/prepare/representation/prepare_game_screen.dart';
import 'package:test_base_flutter/features/home/_root/representation/home_root_screen.dart';
import 'package:test_base_flutter/features/home/dictionary/list/representation/dictionaries_screen.dart';
import 'package:test_base_flutter/features/home/dictionary/terms/representation/terms_screen.dart';
import 'package:test_base_flutter/features/home/dictionary/terms_search/representation/terms_search_screen.dart';
import 'package:test_base_flutter/repository/interfaces/game_repository.dart';
import 'package:test_base_flutter/repository/local/practice_game_repository.dart';
import 'package:test_base_flutter/ui/navigation/router.dart';
import 'package:test_base_flutter/util/navigation_util.dart';

final _homeNavigator = GlobalKey<NavigatorState>();

class HomeRoute {
  static const practice = '/practice';
  static const practiceGame = '/practice-game';
  static const dictionaries = '/dictionaries';
  static const terms = '/terms';
  static const termsSearch = '/terms-search';
}

class HomeParams {
  static const dictionaryId = 'dictionaryId';
  static const questionsCount = 'questionsCount';
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
            child: PrepareGameScreenProvider(),
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
  GoRoute(
    path: HomeRoute.termsSearch,
    name: HomeRoute.termsSearch,
    parentNavigatorKey: rootNavigator,
    builder: (context, state) => TermsSearchScreenProvider(
      dictionaryId: state.getIntQueryParam(HomeParams.dictionaryId) ?? 0,
    ),
  ),
  GoRoute(
    path: HomeRoute.practiceGame,
    name: HomeRoute.practiceGame,
    parentNavigatorKey: rootNavigator,
    builder: (context, state) => RepositoryProvider<GameRepository>(
      create: (context) => PracticeGameRepository(),
      child: RootGameScreenProvider(
        questionsCount: state.getIntQueryParam(HomeParams.questionsCount) ?? 0,
        dictionaryId: state.getIntQueryParam(HomeParams.dictionaryId) ?? 0,
      ),
    ),
  ),
];
