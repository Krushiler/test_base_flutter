import 'package:flutter/material.dart';
import 'package:test_base_flutter/features/home/home_routing.dart';
import 'package:test_base_flutter/repository/remote/remote_repository_provider.dart';
import 'package:test_base_flutter/ui/navigation/router.dart';
import 'package:test_base_flutter/ui/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    App(
      initialRoute: await _getInitialRoute,
    ),
  );
}

class App extends StatelessWidget {
  final String initialRoute;

  const App({
    super.key,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return RemoteRepositoryProvider(
      child: MaterialApp.router(
        routerConfig: createAppRouter(initialRoute),
        title: 'TestBase',
        theme: appTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

Future<String> get _getInitialRoute async {
  return HomeRoute.practice;
}
