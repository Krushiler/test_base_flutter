import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_base_flutter/data/model/dictionary/term.dart';
import 'package:test_base_flutter/features/home/dictionary/terms/representation/components/term_list.dart';
import 'package:test_base_flutter/features/home/dictionary/terms_search/bloc/terms_seach_bloc.dart';
import 'package:test_base_flutter/features/home/dictionary/terms_search/bloc/terms_search_event.dart';
import 'package:test_base_flutter/features/home/dictionary/terms_search/bloc/terms_search_state.dart';
import 'package:test_base_flutter/ui/components/buttons/navigation_back_button.dart';
import 'package:test_base_flutter/ui/components/screen.dart';
import 'package:test_base_flutter/ui/dimens.dart';
import 'package:test_base_flutter/ui/kit/icons.dart';
import 'package:test_base_flutter/ui/kit/svg_button.dart';
import 'package:test_base_flutter/ui/kit/test_base_app_bar.dart';
import 'package:test_base_flutter/util/snackbar_util.dart';

class TermsSearchScreenProvider extends StatelessWidget {
  final int dictionaryId;

  const TermsSearchScreenProvider({
    required this.dictionaryId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TermsSearchBloc>(
      create: (context) => TermsSearchBloc(context.read()),
      child: TermsSearchScreen(dictionaryId: dictionaryId),
    );
  }
}

class TermsSearchScreen extends StatefulWidget {
  final int dictionaryId;

  const TermsSearchScreen({
    required this.dictionaryId,
    Key? key,
  }) : super(key: key);

  @override
  State<TermsSearchScreen> createState() => _TermsSearchScreenState();
}

class _TermsSearchScreenState extends State<TermsSearchScreen> {
  final RefreshController refreshController = RefreshController();
  final TextEditingController searchController = TextEditingController();

  final List<Term> terms = [];
  bool inProgress = false;

  @override
  Widget build(BuildContext context) {
    return ScreenConsumer<TermsSearchBloc, TermsSearchState>(
      padding: EdgeInsets.zero,
      listener: (context, state) {
        if (state is LoadedTermsSearchState) {
          setState(() {
            terms.clear();
            terms.addAll(state.terms);
          });
        }
        if (state is ProgressTermsSearchState) {
          setState(() {
            inProgress = state.progress;
          });
          if (!inProgress) {
            refreshController.refreshCompleted();
          }
        }
        if (state is FailureTermsSearchState) {
          context.showSnackBar(state.message);
        }
      },
      appBar: TestBaseAppBar(
        leading: const NavigationBackButton(),
        title: Padding(
          padding: const EdgeInsets.only(right: Dimens.md),
          child: TextField(
            controller: searchController,
            autofocus: true,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              hintText: 'search...',
              border: InputBorder.none,
              suffix: SvgButton(
                icon: TestBaseIcons.clear,
                onPressed: () {
                  searchController.clear();
                },
              ),
            ),
            onChanged: (text) {
              BlocProvider.of<TermsSearchBloc>(context).add(
                SearchTermsSearchEvent(
                  widget.dictionaryId,
                  text,
                ),
              );
            },
          ),
        ),
      ),
      builder: (context, state) {
        return TermList(
          terms: terms,
          refreshController: refreshController,
          onRefresh: () {
            BlocProvider.of<TermsSearchBloc>(context).add(
              SearchTermsSearchEvent(
                widget.dictionaryId,
                searchController.text,
              ),
            );
          },
        );
      },
      showProgress: (state) => inProgress,
    );
  }
}
