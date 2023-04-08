import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_base_flutter/features/home/home_routing.dart';

final rootNavigator = GlobalKey<NavigatorState>();

GoRouter createAppRouter(String initialLocation) => GoRouter(
      initialLocation: initialLocation,
      navigatorKey: rootNavigator,
      routes: [
        ...homeRoutes,
      ],
    );
