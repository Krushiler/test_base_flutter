import 'package:go_router/go_router.dart';

extension NavigationUtil on GoRouterState {
  int? getIntQueryParam(String key) {
    if (queryParams[key] == null) return null;
    return int.tryParse(queryParams[key]!);
  }
}