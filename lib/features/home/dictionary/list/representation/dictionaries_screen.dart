import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_base_flutter/data/model/dictionary/dictionary.dart';
import 'package:test_base_flutter/features/home/dictionary/list/bloc/dictionaries_bloc.dart';
import 'package:test_base_flutter/features/home/dictionary/list/bloc/dictionaries_event.dart';
import 'package:test_base_flutter/features/home/dictionary/list/bloc/dictionaries_state.dart';
import 'package:test_base_flutter/features/home/dictionary/list/representation/components/dictionary_list.dart';
import 'package:test_base_flutter/features/home/home_routing.dart';
import 'package:test_base_flutter/ui/components/screen.dart';
import 'package:test_base_flutter/ui/dimens.dart';
import 'package:test_base_flutter/ui/kit/gap.dart';
import 'package:test_base_flutter/ui/theme/app_text_theme.dart';
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
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: DictionaryList(
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
                    queryParams: {
                      HomeParams.dictionaryId: dictionary.id.toString()
                    },
                  );
                },
              ),
            ),
            Gap.md,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Powered by',
                  style: Theme.of(context).textTheme.p3?.copyWith(
                        color: const Color(0xFF0A0047),
                        fontFamily: 'Roboto',
                      ),
                ),
                Gap.sm,
                SvgPicture.asset(
                  'assets/icons/powered_by.svg',
                  height: Dimens.lg,
                )
              ],
            ),
            Gap.md,
          ],
        );
      },
      showProgress: (state) => inProgress,
    );
  }
}
