import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_base_flutter/data/model/dictionary/dictionary.dart';
import 'package:test_base_flutter/features/home/dictionary/list/bloc/dictionaries_bloc.dart';
import 'package:test_base_flutter/features/home/dictionary/list/bloc/dictionaries_event.dart';
import 'package:test_base_flutter/features/home/dictionary/list/bloc/dictionaries_state.dart';
import 'package:test_base_flutter/features/home/dictionary/list/representation/components/dictionary_list.dart';
import 'package:test_base_flutter/features/home/home_routing.dart';
import 'package:test_base_flutter/ui/components/screen.dart';
import 'package:test_base_flutter/util/snackbar_util.dart';

class DictionariesScreenProvider extends StatelessWidget {
  const DictionariesScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DictionariesBloc>(
      create: (context) => DictionariesBloc(context.read())
        ..add(
          LoadDictionariesEvent(),
        ),
      child: const DictionariesScreen(),
    );
  }
}

class DictionariesScreen extends StatefulWidget {
  const DictionariesScreen({Key? key}) : super(key: key);

  @override
  State<DictionariesScreen> createState() => _DictionariesScreenState();
}

class _DictionariesScreenState extends State<DictionariesScreen> {
  final List<Dictionary> dictionaries = [];
  bool inProgress = true;

  final refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return ScreenConsumer<DictionariesBloc, DictionariesState>(
      padding: EdgeInsets.zero,
      listener: (context, state) {
        if (state is LoadedDictionariesState) {
          setState(() {
            if (state.refresh) {
              dictionaries.clear();
            }
            dictionaries.addAll(state.dictionaryList.dictionaries);
          });
        }
        if (state is ProgressDictionariesState) {
          setState(() {
            inProgress = state.progress;
          });
          if (!inProgress) {
            refreshController.refreshCompleted();
          }
        }
        if (state is FailureDictionariesState) {
          context.showSnackBar(state.message);
        }
      },
      builder: (context, state) {
        return DictionaryList(
          dictionaries: dictionaries,
          refreshController: refreshController,
          onRefresh: () {
            BlocProvider.of<DictionariesBloc>(context).add(
              LoadDictionariesEvent(refresh: true),
            );
          },
          onDictionaryPressed: (dictionary) {
            context.pushNamed(
              HomeRoute.terms,
              queryParams: {HomeParams.dictionaryId: dictionary.id.toString()},
            );
          },
        );
      },
      showProgress: (state) => inProgress,
    );
  }
}
