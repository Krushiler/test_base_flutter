import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_base_flutter/repository/interfaces/dictonary_repository.dart';
import 'package:test_base_flutter/repository/local/local_dictionary_repository.dart';

class LocalRepositoryProvider extends StatelessWidget {
  final Widget child;

  const LocalRepositoryProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider<DictionaryRepository>(
        create: (context) => LocalDictionaryRepository(),
      ),
    ], child: child);
  }
}
