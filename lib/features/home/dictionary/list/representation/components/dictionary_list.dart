import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_base_flutter/data/model/dictionary/dictionary.dart';
import 'package:test_base_flutter/features/home/dictionary/list/representation/components/dictionary_list_item.dart';
import 'package:test_base_flutter/ui/dimens.dart';
import 'package:test_base_flutter/ui/theme/app_colors.dart';

class DictionaryList extends StatefulWidget {
  final List<Dictionary> dictionaries;
  final void Function(Dictionary)? onDictionaryPressed;
  final VoidCallback? onRefresh;
  final RefreshController refreshController;

  const DictionaryList({
    Key? key,
    required this.dictionaries,
    this.onDictionaryPressed,
    this.onRefresh,
    required this.refreshController,
  }) : super(key: key);

  @override
  State<DictionaryList> createState() => _DictionaryListState();
}

class _DictionaryListState extends State<DictionaryList> {
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
        itemBuilder: (context, index) => DictionaryListItem(
          name: widget.dictionaries[index].name,
          onPressed: () {
            widget.onDictionaryPressed?.call(
              widget.dictionaries[index],
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
        itemCount: widget.dictionaries.length,
      ),
    );
  }
}
