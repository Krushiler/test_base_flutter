import 'package:flutter/material.dart';
import 'package:test_base_flutter/ui/dimens.dart';

class TestBaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final Widget? title;
  final Widget? leading;

  const TestBaseAppBar({
    Key? key,
    this.actions,
    this.title,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget>? paddedActions = actions
        ?.map(
          (e) => Center(
            child: Padding(
              padding: const EdgeInsets.only(right: Dimens.md),
              child: e,
            ),
          ),
        )
        .toList();

    return AppBar(
      actions: paddedActions,
      title: title,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(Dimens.xxl);
}
