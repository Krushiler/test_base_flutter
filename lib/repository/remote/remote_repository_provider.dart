import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_base_flutter/repository/interfaces/dictonary_repository.dart';
import 'package:test_base_flutter/repository/remote/remote_dictionary_repository.dart';

class RemoteRepositoryProvider extends StatelessWidget {
  final Widget child;

  const RemoteRepositoryProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider<DictionaryRepository>(
        create: (context) => RemoteDictionaryRepository(),
      ),
    ], child: child);
  }
}
