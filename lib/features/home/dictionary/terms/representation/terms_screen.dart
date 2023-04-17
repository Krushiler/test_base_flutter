import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_base_flutter/data/model/dictionary/term.dart';
import 'package:test_base_flutter/features/home/dictionary/terms/bloc/terms_bloc.dart';
import 'package:test_base_flutter/features/home/dictionary/terms/bloc/terms_event.dart';
import 'package:test_base_flutter/features/home/dictionary/terms/bloc/terms_state.dart';
import 'package:test_base_flutter/features/home/dictionary/terms/representation/components/term_list.dart';
import 'package:test_base_flutter/features/home/home_routing.dart';
import 'package:test_base_flutter/ui/components/buttons/navigation_back_button.dart';
import 'package:test_base_flutter/ui/components/screen.dart';
import 'package:test_base_flutter/ui/kit/icons.dart';
import 'package:test_base_flutter/ui/kit/svg_button.dart';
import 'package:test_base_flutter/ui/kit/test_base_app_bar.dart';
import 'package:test_base_flutter/util/snackbar_util.dart';

class TermsScreenProvider extends StatelessWidget {
  final int dictionaryId;

  const TermsScreenProvider({
    required this.dictionaryId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TermsBloc>(
      create: (context) => TermsBloc(context.read())
        ..add(
          LoadTermsEvent(dictionaryId),
        ),
      child: TermsScreen(dictionaryId: dictionaryId),
    );
  }
}

class TermsScreen extends StatefulWidget {
  final int dictionaryId;

  const TermsScreen({
    required this.dictionaryId,
    Key? key,
  }) : super(key: key);

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  final RefreshController refreshController = RefreshController();

  final List<Term> terms = [];
  String dictionaryName = '';
  bool inProgress = true;

  @override
  Widget build(BuildContext context) {
    return ScreenConsumer<TermsBloc, TermsState>(
      padding: EdgeInsets.zero,
      listener: (context, state) {
        if (state is LoadedTermsState) {
          setState(() {
            if (state.refresh) {
              terms.clear();
            }
            terms.addAll(state.terms);
            dictionaryName = state.dictionaryName;
          });
        }
        if (state is ProgressTermsState) {
          setState(() {
            inProgress = state.progress;
          });
          if (!inProgress) {
            refreshController.refreshCompleted();
          }
        }
        if (state is FailureTermsState) {
          context.showSnackBar(state.message);
        }
      },
      appBar: TestBaseAppBar(
        leading: const NavigationBackButton(),
        title: Text(dictionaryName),
        actions: [
          SvgButton(
            icon: TestBaseIcons.search,
            onPressed: () {
              context.pushNamed(HomeRoute.termsSearch, queryParams: {
                HomeParams.dictionaryId: widget.dictionaryId.toString(),
              });
            },
          )
        ],
      ),
      builder: (context, state) {
        return TermList(
          terms: terms,
          refreshController: refreshController,
          onRefresh: () {
            BlocProvider.of<TermsBloc>(context).add(LoadTermsEvent(
              widget.dictionaryId,
              refresh: true,
            ));
          },
        );
      },
      showProgress: (state) => inProgress,
    );
  }
}
