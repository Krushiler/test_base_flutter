import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_base_flutter/data/model/terms/term.dart';
import 'package:test_base_flutter/features/home/dictionary/terms/representation/components/term_list_item.dart';
import 'package:test_base_flutter/ui/dimens.dart';
import 'package:test_base_flutter/ui/theme/app_colors.dart';

class TermList extends StatefulWidget {
  final List<Term> terms;
  final void Function(Term)? onTermPressed;
  final VoidCallback? onRefresh;
  final RefreshController refreshController;

  const TermList({
    Key? key,
    required this.terms,
    this.onTermPressed,
    this.onRefresh,
    required this.refreshController,
  }) : super(key: key);

  @override
  State<TermList> createState() => _TermListState();
}

class _TermListState extends State<TermList> {
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: widget.refreshController,
      onRefresh: widget.onRefresh,
      header: MaterialClassicHeader(
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: ListView.separated(
          physics: RefreshPhysics(controller: widget.refreshController),
          padding: const EdgeInsets.symmetric(vertical: Dimens.md),
          itemBuilder: (context, index) => TermListItem(
                name: widget.terms[index].name,
                description: widget.terms[index].description,
                onPressed: () {
                  widget.onTermPressed?.call(
                    widget.terms[index],
                  );
                },
              ),
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: Dimens.md),
                child: Divider(
                  height: 1,
                  color: AppColors.gray.shade200,
                ),
              ),
          itemCount: widget.terms.length),
    );
  }
}
